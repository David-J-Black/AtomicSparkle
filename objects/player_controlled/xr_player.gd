extends XROrigin3D
class_name XRPlayer

enum Hand {
	LEFT,
	RIGHT
}

var xr_interface: XRInterface

func _ready():
	
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
		


func _on_left_hand_input_vector_2_changed(name: String, value: Vector2) -> void:
	print("Left hand vector 2 change [%s, %s]" % [name, value] )
	pass # Replace with function body.

func get_xr_hand(hand: Hand) -> XRController3D:
	if hand == Hand.LEFT:
		return $LeftHand
	elif hand == Hand.RIGHT:
		return $RightHand
	return null
