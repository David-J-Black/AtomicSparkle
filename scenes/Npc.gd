extends StaticBody3D

@onready var animation_player = $blenderNode
@onready var dialog_node = $DialogNode
@export var dialog: String = ""

func _ready():
	print("The Animation player is", animation_player)
	animation_player.play_animation("idle", Animation.LOOP_PINGPONG)
	

func on_player_interact():
	if !dialog:
		print("This object has no dialog! Cannot interact", name)
		return		
	DialogService.create_dialog_box(dialog, dialog_node.global_position)
