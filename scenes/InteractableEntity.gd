extends StaticBody3D
class_name InteractableEntity

@export var dialog: String = ""

func on_player_interact():
	if !dialog:
		print("This object has no dialog! Cannot interact", name)
		return		
	DialogService.create_dialog_box(dialog)
	

