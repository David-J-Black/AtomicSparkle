extends Node

## The entity at which the camera is pointed at
var camera_base: CameraHandler
var xr_camera: XRCamera3D
	
var warned_about_missing_camera_or_player: bool = false

func _process(delta):
	if not XRPlayerService.xr_enabled:
		move_camera_to_player()
	
func move_camera_to_player():
	var player = GameService.player
	
	if camera_base != null and player != null:
		
		# If the camera is already at the player, then move nothing
		if camera_base.position != player.position:
			camera_base.position = player.position
		return
	
	if not warned_about_missing_camera_or_player:
		printerr("Cannot move camera_base to player missing camera [%s] or player [%s]" % [camera_base, player])
		warned_about_missing_camera_or_player = true

func unproject_position(position: Vector3) -> Vector2:
	
	if !position:
		return Vector2.ZERO

	for child in camera_base.get_children():
		if child is Camera3D:
			return child.unproject_position(position)
	
	return Vector2.ZERO
	
func get_camera_transform() -> Transform3D:
	if XRPlayerService.xr_enabled:
		return Vector3.ZERO if xr_camera == null else xr_camera.transform
	return Vector3.ZERO if camera_base == null or camera_base.camera == null else camera_base.camera.transform
