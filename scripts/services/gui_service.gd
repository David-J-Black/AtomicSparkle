extends Node

var touch_buttons: Control

func setup(touch_buttons: Control) -> void:
	assert(touch_buttons != null, "No touch buttons found in game!")
	self.touch_buttons = touch_buttons
	_resize()
	get_viewport().connect("size_changed", Callable(self, "_resize"))
	
func hide():
	if touch_buttons != null:
		touch_buttons.visible = false
	
func show():
	if touch_buttons != null:
		touch_buttons.visible = true
	
func _process(delta: float) -> void:

	if Input.is_action_just_pressed("toggle_touch_buttons"):
		print("Toggle button pressed")
		touch_buttons.visible = !touch_buttons.visible

func _resize() -> void:
	var viewport_size = get_viewport().get_size()
	if viewport_size.x < viewport_size.y:
		touch_buttons.visible = true
	else:
		touch_buttons.visible = false
