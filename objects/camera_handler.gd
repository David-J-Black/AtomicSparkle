extends Node3D
class_name CameraHandler

# Control Mouse Sensitivity through inspector or from here
@export var mouse_sensitivity := 0.2
@export var analog_sensitivity: float = 5

@export var acceptable_x_range := [-80, 80]

var velocity: Vector2 = Vector2.ZERO
@onready var camera: Camera3D = $Camera3D
	
func _init() -> void:
	CameraService.camera_base = self
	
func _input(event: InputEvent):
	pass
	#if event is InputEventMouseMotion and Input.is_action_pressed('mouse_click'):
				#print("Mouse Clicked")
				#rotation_degrees.x -= event.relative.y * mouse_sensitivity
				#rotation_degrees.x = clamp(rotation_degrees.x, -80, 80)
#
				#rotation_degrees.y -= event.relative.x * mouse_sensitivity
				#rotation_degrees.y = wrapf(rotation_degrees.y, 0, 360)


func _process(delta):
	
	if not XRPlayerService.xr_enabled and not $Camera3D.current:
		$Camera3D.current = true
		
	var initial_rotation = Vector2(rotation_degrees.x, rotation_degrees.y)
	# Controller input...
	var input_dir: Vector2 = Input.get_vector("camera_left", "camera_right", "camera_forward", "camera_ backward")

	if input_dir != Vector2.ZERO:

		# Stick moving up/down
		rotation.x += -input_dir.y * analog_sensitivity * delta

		# Stick moving left/right
		rotation.y += -input_dir.x * analog_sensitivity * delta

		velocity = initial_rotation - Vector2(rotation_degrees.x, rotation_degrees.y)
