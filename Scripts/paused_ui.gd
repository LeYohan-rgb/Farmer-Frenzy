extends Node2D

signal denied_return_to_main_menu
signal approve_return_to_main_menu

func _on_x_iconss_pressed() -> void:
	denied_return_to_main_menu.emit()


func _on_check_icons_pressed() -> void:
	approve_return_to_main_menu.emit()
