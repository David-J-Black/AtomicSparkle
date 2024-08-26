extends Node

var DialogBox := preload("res://components/DialogBox.tscn")
var dialogs: Node = Node.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Attach our dialogs array to scenetree
	dialogs.name = "Dialogs"
	add_child(dialogs)

func _exit_tree():
	print("Dialog tree closing")

func create_dialog_box(message: String):
	var box: DialogBox = DialogBox.instantiate()
	if box:
		box.add_text(message)
		dialogs.add_child(box)
