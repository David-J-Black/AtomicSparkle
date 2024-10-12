extends Control

@export var button_label := "Action"
@export var input_action := "ui_accept"

@onready var _label: Label =  $Label
@onready var _button: TouchScreenButton = $TouchScreenButton

func _ready() -> void:
	_label.text = button_label


func _on_touch_screen_button_pressed() -> void:
	Input.action_press(input_action)
	_label.add_theme_color_override("font_color", Color.GRAY)


func _on_touch_screen_button_released() -> void:
	Input.action_release(input_action)
	_label.remove_theme_color_override("font_color")
