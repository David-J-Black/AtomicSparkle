extends Node

var virtual_joystick: VirtualJoystick

func setup(virtual_joystick: VirtualJoystick) -> void:
	assert(virtual_joystick != null, "No virtual joystick found in game!")
	self.virtual_joystick = virtual_joystick
	#_resize()
	#get_viewport().connect("size_changed", Callable(self, "_resize"))

#func _resize() -> void:
	#var viewport_size = get_viewport().get_size()
	#_virtual_joystick.size = viewport_size
	pass
	#position = (viewport_size - Vector2i(size)) / 2
