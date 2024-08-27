extends Node

var DialogBoxScene := preload("res://components/DialogBox.tscn")
var dialogs: Node = Node.new()
var is_in_dialog: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Attach our dialogs array to scenetree
	dialogs.name = "Dialogs"
	add_child(dialogs)

func _exit_tree():
	print("Dialog tree closing")

func create_dialog_box(message: String, dialogPosition: Vector3):
	is_in_dialog = true
	var box: DialogBox = DialogBoxScene.instantiate()
	
	box.add_text(message)
	dialogs.add_child(box)
	
	# Set position, get the position from scene and convert it to 2d position
	var flat_pos: Vector2 = CameraService.unproject_position(dialogPosition)
	var box_dimensions: Vector4 = box.get_dimensions()
	flat_pos = Vector2(-box_dimensions.w, box_dimensions.x) - Vector2(box_dimensions.y, box_dimensions.z) / 2
	print("Screen position:", flat_pos)
	box.set_position(flat_pos)
