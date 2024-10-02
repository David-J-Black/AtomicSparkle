extends Control
class_name SaveMenu

@onready var save_list: VBoxContainer = $SaveMenu/PanelContainer/MarginContainer/SaveList
@onready var load_button: Button = $SaveMenu/Buttons/Load
@onready var name_window: PanelContainer = $NameWindow
	
var selected: String

func _ready() -> void:
	self.visible = true
	name_window.visible = false
	load_saves()
	
func _visibility_changed():
	print("Visibility changed on save menu")
		
func load_saves() -> void:
	for prev_save in save_list.get_children():
		prev_save.queue_free()
	# Populate the save list
	var saves: Array[String] = SaveService.get_save_names()

	for save in saves:
		_add_file_entry(save)
		
func _on_new_pressed():
	name_window.visible = true
	name_window.grab_focus()
		
func _on_load_pressed() -> void:
	assert(selected != null, "SAVE NAME NULL? DUDE LOOK INTO THIS")
	SaveService.load_save_file(selected)
	
func _on_file_pressed(save_name: String) -> void:
	print("selected [%s]" % save_name)
	selected = save_name

# This shit is so cheese
func bring_menu_to_front(menu: Control) -> void:
	remove_child(menu)
	add_child(menu)
	
# Adds a save to the list of saves
func _add_file_entry(save_name: String) -> void:
	var button = Button.new()
	button.alignment = HORIZONTAL_ALIGNMENT_LEFT
	button.text = save_name
	button.name = save_name
	button.toggle_mode
	button.focus_mode = Control.FOCUS_ALL
	button.connect("pressed", Callable(self, "_on_file_pressed").bind(save_name))
	
	print("save_name [%s]" % save_name)
	print(" Parent save name [%s]" % SaveService.save_name)
	save_list.add_child(button)
	
	if save_name == SaveService.save_name:
		button.grab_focus()
		selected = save_name
		print("Focused on [%s]" % save_name)

func _on_save_pressed() -> void:
	print("Save was pressed")
	var name_editor = $NameWindow/VBoxContainer/MarginContainer/TextEdit
	name_editor.text = selected
	name_window.visible = true


func _on_name_menu_save_pressed() -> void:
	var name_editor = $NameWindow/VBoxContainer/MarginContainer/TextEdit
	
	if (name_editor.text == ""):
		return
		
	# TODO: Add a check so user can't overwrite old saves on accerdent
	SaveService.save_game(name_editor.text)
	name_window.visible = false
	load_saves()


func _on_name_menu_cancel_pressed() -> void:
	var name_editor: TextEdit = $NameWindow/VBoxContainer/MarginContainer/TextEdit
	name_window.visible = false
	name_editor.text = ""
