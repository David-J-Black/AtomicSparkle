extends XROrigin3D
class_name XRPlayer

## How far is XR player allowed to be from Main Character
@export var tether_distance: float = 5.0
@export var tether_force: float = 10

enum Hand {
	LEFT,
	RIGHT
}

var xr_interface: XRInterface
var tethered_to: Node3D
@onready var player_body: XRToolsPlayerBody = $PlayerBody

func _ready():
	
	# Attatch player character
	tethered_to = GameService.player
	if tethered_to == null:
		printerr("XR Player not tethered to main character!")
		
	XRPlayerService.xr_player = self	
	CameraService.xr_camera = $XRCamera3D
	DK.set_current_camera($XRCamera3D)
	
	
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialized successfully")

		# Turn off v-sync!
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

		# Change our main viewport to output to the HMD
		get_viewport().use_xr = true
	else:
		print("OpenXR not initialized, please check if your headset is connected")
	
func _physics_process(delta: float) -> void:
	_tether_player()
	

## If there is a character assigned to this XRPlayer, then we follow them
func _tether_player() -> void:
	
	# If we don't have a target, ignore
	if tethered_to == null:
		return
	
	var target_origin: Vector3 = tethered_to.global_transform.origin
	var our_origin: Vector3 = global_transform.origin
	var distance = target_origin.distance_to(our_origin)
		
	# If the distance between us and the target is shorter than tether length, we are interested
	if distance <= tether_distance:
		return
		
	# Move towards target
	var direction = our_origin.direction_to(target_origin)
	player_body.velocity = Vector3(direction.x, 0, direction.z) * tether_force
	

func _on_left_hand_input_vector_2_changed(name: String, value: Vector2) -> void:
	print("Left hand vector 2 change [%s, %s]" % [name, value] )
	pass # Replace with function body.

func get_xr_hand(hand: Hand) -> XRController3D:
	if hand == Hand.LEFT:
		return $LeftHand
	elif hand == Hand.RIGHT:
		return $RightHand
	return null
