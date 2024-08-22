extends CharacterBody3D

var InteractableEntity: PackedScene = preload("res://scenes/InteractableEntity.tscn")

const SPEED = 5.0
@export var jump_velocity = 5

@onready var interact_pivot: Node3D = $InteractPivot
@onready var interact_area: Area3D = $InteractPivot/InteractArea
@onready var player_model: MeshInstance3D = $MeshInstance3D
@onready var jump_hold_time_limit: float = 0.1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var jump_hold_time: float = 0
var has_ground_been_touched: bool = true

func _unhandled_input(event: InputEvent) -> void:

	if Input.is_action_just_pressed("interact"):
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
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")

	if input_dir.length() > 0:

		var camera: Node3D = CameraService.get_camera_base()
		
		if camera: 
			# Now consider the camera rotation with how to process the analog input
			input_dir = input_dir.rotated(-camera.rotation.y).normalized()
			
		#Rotate the player model (Dont ask me why the input_dir has to be negated
		interact_pivot.rotation.y = -input_dir.angle()
		player_model.rotation.y = -input_dir.angle()
#		rotation.y = -input_dir.angle()

	
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = input_dir.x * SPEED
		velocity.z = input_dir.y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
func process_jump(delta: float):

	# If player holds jump, they can jump a little higher!
	if Input.is_action_just_pressed("jump") && has_ground_been_touched:
		jump_hold_time = jump_hold_time_limit
		has_ground_been_touched = false
	else:
		# process the time delta...
		jump_hold_time -= delta
		
	if Input.is_action_pressed("jump") and jump_hold_time > 0 and has_ground_been_touched:
		velocity.y = jump_velocity
	
	
