extends StaticBody3D
class_name InteractableEntity

@onready var animation_player = $little
@export var dialog: String = ""

func _ready():
	print("The Animation player is", animation_player)
	

func on_player_interact():
	if !dialog:
		print("This object has no dialog! Cannot interact", name)
		return		
	DialogService.create_dialog_box(dialog)
