extends Node2D


@onready var farmer_frenzy_mode = $farmer_frenzy
@onready var main_menu_layout = $main
@onready var settings_menu = $main/settings_menu

func _ready():
	farmer_frenzy_mode.connect("go_to_main_menu", go_back_to_main_menu)
	settings_menu.connect("hide_settings", hide_settings)

func _on_farmer_fight_button_pressed() -> void:
	farmer_frenzy_mode.begin_game()
	main_menu_layout.hide()
	farmer_frenzy_mode.show()
	
func go_back_to_main_menu():
	farmer_frenzy_mode.hide()
	main_menu_layout.show()
	get_tree().paused = false
	
func hide_settings():
	settings_menu.hide()


func _on_settings_button_pressed() -> void:
	settings_menu.show()
