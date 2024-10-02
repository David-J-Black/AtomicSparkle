extends Node3D

func _init():
	print("Hello, this should be the start of the program")

func _ready():
	# Open a menu
	var camera_base: Node3D = $CameraBase
	var player: CharacterBody3D = $Player
	CameraService.set_camera_base(camera_base)
	CameraService.set_player(player)
