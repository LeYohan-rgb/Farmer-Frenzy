extends Node2D


@onready var farmer_frenzy_mode = $farmer_frenzy
@onready var main_menu_layout = $main


func _on_farmer_fight_button_pressed() -> void:
	farmer_frenzy_mode.begin_game()
	main_menu_layout.hide()
	farmer_frenzy_mode.show()
	
