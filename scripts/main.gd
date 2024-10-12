extends Node3D

@onready var level_anchor: Node3D = $LevelAnchor
@onready var player: CharacterBody3D = $Player
@onready var camera_base: Node3D = $CameraBase
@onready var touch_buttons: Control = $UI/TouchButtons

func _init():
	print("Hello, this should be the start of the program")

func _ready():
	# Open a menu
	CameraService.setup(camera_base)
	LevelService.setup(level_anchor)
	GuiService.setup(touch_buttons)
	
