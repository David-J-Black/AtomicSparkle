extends Control
class_name MainMenu

var MENU_SCALE: float = 0.9

# This is a dictionary of all the menus in the main menu
# We can use this to show/hide menus
@onready var menus: Dictionary = {
	"save": $MainMenuPanel/MarginContainer/HBoxContainer/Window/SaveMenu,
	"journal": $MainMenuPanel/MarginContainer/HBoxContainer/Window/JournalMenu
}

# This is the selected menu
var selected_menu: String = "save"

@onready var panel: Panel = $MainMenuPanel

func _ready() -> void:
	_resize()
	get_viewport().connect("size_changed", Callable(self, "_resize"))

func _resize() -> void:
	var viewport_size = get_viewport().get_size()
	print("Viewport size ", viewport_size)
	panel.size = viewport_size
	#position = (viewport_size - Vector2i(size)) / 2
	
# Show the save menu
func _on_save_pressed() -> void:
	select_menu("save")

# Show the journal menu
func _on_journal_pressed() -> void:
	select_menu("journal")

# Select a menu
# If menu name is null, then double check the selected menu
# Returns the menu that was selected
func select_menu(menu_name: String = "") -> Control:
	if menu_name == "":
		menu_name = selected_menu
	for menu in menus.values():
		if menu != null:
			menu.visible = false
			
	if menus.has(menu_name):
		menus[menu_name].visible = true
		return menus[menu_name]
	return null


func _on_new_game_pressed() -> void:
	SaveService.new_save_file("New Game")


func _on_close_pressed() -> void:
	MenuService.set_visible(false)
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	GameService.end_game()
	pass # Replace with function body.
