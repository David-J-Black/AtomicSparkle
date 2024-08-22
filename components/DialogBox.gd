extends Control
class_name DialogBox

func add_text(message: String):
	self.visible = true
	var dialog_element = $ColorRect/VBoxContainer/TextBackground/DialogElement
	dialog_element.text = message

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event: InputEvent) -> void:

	if event.is_action_pressed("ui_confirm"):
		close()

func _on_ok_button_pressed():
	print("Pressed button")
	var dialog_element = $ColorRect/VBoxContainer/TextBox/DialogElement
	
	if dialog_element:
		dialog_element.text = "Howdy partner"
	self.visible = false


func _on_close_button_pressed():
	close()

func close():
	queue_free()
