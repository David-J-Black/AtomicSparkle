extends CharacterBody3D
class_name Player

var InteractableEntity: PackedScene = preload("res://scenes/Npc.tscn")

const SPEED = 5.0
const ROTATIONAL_SPEED = 0.1

@export var jump_velocity = 5

@onready var interact_area: Area3D = $InteractPivot/InteractArea
@onready var player_model: CharacterModel = $blenderNode
@onready var jump_hold_time_limit: float = 0.1

## Suspend controlling of the player character
var control_is_paused := false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var jump_hold_time: float = 0
var has_ground_been_touched: bool = true

func _ready():
	player_model.play_animation("idle", Animation.LOOP_PINGPONG)

func _input(_event: InputEvent) -> void:
	
	if Input.is_action_just_pressed("interact") and not are_controls_suspended():
		print("Interact pressed")

		var overlapping_bodies: Array[Node3D] = interact_area.get_overlapping_bodies()

		for body in overlapping_bodies:
			if body.name != "Player":
				print("Interacting with ", body.name)

				if body.has_method("on_player_interact"):
					body.on_player_interact()

func _physics_process(delta):
	process_jump(delta)

	# Add the gravity.
	if is_on_floor():
		has_ground_been_touched = true
	else:
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir: Vector2 = Vector2.ZERO if are_controls_suspended() else get_input_direction()

	if input_dir.length() > 0:
		rotate_player(input_dir)

	if input_dir and !DialogService.is_in_dialog():
		walk(input_dir)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	_process_walking_animation()
	move_and_slide()
	
func walk(input_dir):	
	velocity = Vector3(input_dir.x * SPEED, velocity.y, input_dir.y * SPEED)


func _process_walking_animation() -> void:
	if velocity.length() > 2:
		player_model.play_animation("walk", Animation.LoopMode.LOOP_LINEAR, 0.5)
		player_model.animation_player.speed_scale = 1.75
	else:
		player_model.play_animation("idle", Animation.LoopMode.LOOP_PINGPONG, 0.5)
		player_model.animation_player.speed_scale = 1

## Rotate's the player in the given direction
## to be used within the _processing() function
func rotate_player(input_dir: Vector2):
	var current_angle: float = self.rotation.y
	var desired_angle: float = -input_dir.angle()
	self.rotation.y = lerp_angle(current_angle, desired_angle, ROTATIONAL_SPEED)


# Adjust's the input direction so we know where the player wants to go
# Outputs it on an xz plane
func get_input_direction() -> Vector2:
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var camera: Node3D = CameraService.camera_base
	if camera:
		# Now consider the camera rotation with how to process the analog input
		# *touches earth: "Linear algebra was here..."
		input_dir = input_dir.rotated(-camera.rotation.y)
	return input_dir
	
func process_jump(delta: float) -> void:

	# If player holds jump, they can jump a little higher!
	if Input.is_action_just_pressed("jump")\
		and has_ground_been_touched\
		and not are_controls_suspended():
			
		jump_hold_time = jump_hold_time_limit
		has_ground_been_touched = false
	else:
		# process the time delta...
		jump_hold_time -= delta
		
	if Input.is_action_pressed("jump")\
		and jump_hold_time > 0\
		and has_ground_been_touched\
		and not are_controls_suspended():
			
		velocity.y = jump_velocity
	
## Checks to see if the player character should be responding to input
func are_controls_suspended() -> bool:
	return DialogService.is_in_dialog()
