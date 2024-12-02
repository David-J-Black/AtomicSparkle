extends Node

## The entity at which the camera is pointed at
var camera_base: Node3D:
	set(value):
		if (value != null):
			camera = value.get_child(0)
		camera_base = value

var camera: Camera3D = null
var xr_origin: XROrigin3D:
	set(value):
		if(value != null):
			self.add_child(xr_origin)
		xr_origin = value
	
var warned_about_missing_camera_or_player: bool = false

func setup(camera_base: Node3D):
	self.camera_base = camera_base

func _process(delta):
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
