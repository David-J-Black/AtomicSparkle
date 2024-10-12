extends Node

var current_dialog: CanvasLayer
var next_timeline: String
	
func _ready() -> void:
	# Connect dialogic signals to functions
	Dialogic.timeline_ended.connect(Callable(self, "_dialog_end"))
	Dialogic.timeline_started.connect(Callable(self, "_dialog_start"))
	get_viewport().connect("size_changed", Callable(self, "_resize"))
	
# Start a dialog and specify what scene should play after dialog
func start_dialog(dialog_name: String) -> void:
	Dialogic.paused = false
	MenuService.set_visible(false)
	
	if current_dialog != null:
		#Dialogic.end_timeline()
		Dialogic.clear()
		Dialogic.start_timeline(dialog_name)
	else:
		set_current_dialog(Dialogic.start(dialog_name))

	# Make sure our scene name is up to date
	if dialog_name == null:
		dialog_name = GameService.get_scene_name()
		

func set_current_dialog(timeline: Variant):
	timeline.name = "dialog"
	timeline.layer = 1
	get_node("/root/Main/DialogAnchor").add_sibling(timeline)
	current_dialog = timeline
	
func stop_dialog() -> void:
	print("Stopping dialog (JK THIS IS JUST A PRINT)")
	Dialogic.end_timeline()
	

func _dialog_end() -> void:
	print("Dialog ended")
	GuiService.show()
	
func _dialog_start() -> void:
	print("Dialog started")
	GuiService.hide()
	
# Tells you if the user is currently in a dialog menu
func is_in_dialog() -> bool:
	return current_dialog != null

# Process the size of the window
func _resize() -> void:
	var viewport_size = get_viewport().get_size()	
	#position = (viewport_size - Vector2i(size)) / 2
