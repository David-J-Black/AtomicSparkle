extends StaticBody3D

@onready var animation_player = $blenderNode
@onready var dialog_node = $DialogNode
@export var timeline_name: String = ""

func _ready():
	print("The Animation player is", animation_player)
	animation_player.play_animation("idle", Animation.LOOP_PINGPONG)
	

func on_player_interact():
	if !timeline_name:
		print("This object has no dialog! Cannot interact", name)
		return		
	DialogService.start_dialog(timeline_name)
