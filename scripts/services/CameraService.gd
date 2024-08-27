extends Node

@onready var _active_camera_base: Node3D
@onready var _player: CharacterBody3D

func set_camera_base(camera: Node3D) -> void:
	_active_camera_base = camera
	
func get_camera_base() -> Node3D:
	return _active_camera_base
	
func set_player(player: CharacterBody3D) -> void:
	_player = player

func _process(delta):
	move_camera_to_player()
	
func move_camera_to_player():
	if _active_camera_base and _player:
		_active_camera_base.position = _player.position
	else:
		print("WHERE IS PLAYER OR CAMERA", _active_camera_base, _player)
