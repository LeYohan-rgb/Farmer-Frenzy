extends Node2D

signal end_of_game(winner_farmer : int)

@onready var hp_bar_1 = $first_player/health_bar
@onready var hp_bar_2 = $second_player/health_bar

func _process(delta: float) -> void:
	if !Global.is_in_farmer_fight:
		return
		
	hp_bar_1.value = Global.player_1_health
	hp_bar_2.value = Global.player_2_health
	
	#HEALTHBAR COLORS
	if hp_bar_1.value / hp_bar_1.max_value > 0.5:
		hp_bar_1.get_theme_stylebox("fill").bg_color = Color("72ac4e")
		
	if hp_bar_1.value / hp_bar_1.max_value <= 0.5 and hp_bar_1.value / hp_bar_1.max_value > 0.25:
		hp_bar_1.get_theme_stylebox("fill").bg_color = Color("cbac4e")
		
	if hp_bar_1.value / hp_bar_1.max_value <= 0.25:
		hp_bar_1.get_theme_stylebox("fill").bg_color = Color("de6e63")
		
	if hp_bar_2.value / hp_bar_2.max_value > 0.5:
		hp_bar_2.get_theme_stylebox("fill").bg_color = Color("72ac4e")
		
	if hp_bar_2.value / hp_bar_2.max_value <= 0.5 and hp_bar_2.value / hp_bar_2.max_value > 0.25:
		hp_bar_2.get_theme_stylebox("fill").bg_color = Color("cbac4e")
		
	if hp_bar_2.value / hp_bar_2.max_value <= 0.25:
		hp_bar_2.get_theme_stylebox("fill").bg_color = Color("de6e63")
		
	if Global.player_1_health <= 0:
		end_of_game.emit(1)
		
	if Global.player_2_health <= 0:
		end_of_game.emit(2)
		
	
