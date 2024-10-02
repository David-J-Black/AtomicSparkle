extends VBoxContainer

func _ready() -> void:
	get_viewport().connect("size_changed", Callable(self, "_resize"))

func _resize() -> void:
	print("Resize detected")
	var viewport_size: Vector2 = get_viewport().get_size()
