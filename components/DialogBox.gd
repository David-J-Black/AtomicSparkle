extends Control
class_name DialogBox

@onready var color_rect: ColorRect = $ColorRect

func get_dimensions() -> Vector4:
	return Vector4(color_rect.position.x, color_rect.position.y, color_rect.size.x, color_rect.size.y)

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

func _exit_tree():
	if DialogService.dialogs.get_child_count() <= 1:
		DialogService.is_in_dialog = false

func _on_close_button_pressed():
	close()

func close():
	queue_free()
