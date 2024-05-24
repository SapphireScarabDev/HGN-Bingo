extends Control
class_name BingoSquareRender

@onready var GameButton : Button = get_node("Button")
@onready var ButtonLabel : Label = get_node("Button/Label")

@export var text : String = "" : set = _set_text

@export var is_button_pressed : bool = false : get = _get_is_button_pressed

func reset() -> void:
	text = ""
	GameButton.button_pressed = false

func force_press() -> void:
	GameButton.button_pressed = true

func _set_text(value : String) -> void:
	text = value
	
	ButtonLabel.text = value

func _get_is_button_pressed() -> bool:
	return GameButton.button_pressed

func _on_button_toggled(button_pressed):
	SavesManager.save_data()
