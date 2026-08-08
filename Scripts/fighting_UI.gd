extends Node2D

signal end_of_game(winner_farmer : int)

signal fruit_ability(ability : int, player : int)

@onready var hp_bar_1 = $first_player/health_bar
@onready var hp_bar_2 = $second_player/health_bar
@onready var shield_ui_1 = $first_player/seeds_indicator/shield_icon
@onready var shield_ui_2 = $second_player/seeds_indicator/shield_icon
@onready var timer = $pausing_fight_UI
@onready var bean_lbl_1 = $first_player/seeds_indicator/bean_label
@onready var bean_lbl_2 = $second_player/seeds_indicator/bean_label
@onready var kernel_lbl_1 = $first_player/seeds_indicator/corn_label
@onready var kernel_lbl_2 = $second_player/seeds_indicator/corn_label

@onready var papaya_spr_1 = $fruit_UI/papaya_spr_1
@onready var papaya_spr_2 = $fruit_UI/papaya_spr_2
@onready var papaya_lbl_1 = $fruit_UI/papaya_lbl_1
@onready var papaya_lbl_2 = $fruit_UI/papaya_lbl_2

@export var bean : PackedScene

var bean_spawn_1 : int = -1
var bean_spawn_2 : int = -1

func _ready() -> void:
	timer.connect("second_passed", chance_of_spawn_bean)
	
func _process(delta: float) -> void:
	if !Global.is_in_farmer_fight:
		return
	

	Global.player_1_health = clamp(Global.player_1_health, 0.0, Global.maximum_health)
	Global.player_2_health = clamp(Global.player_2_health, 0.0, Global.maximum_health)
	
	hp_bar_1.value = Global.player_1_health
	hp_bar_2.value = Global.player_2_health
	
	bean_lbl_1.text = str(Global.bean_amount[0])
	bean_lbl_2.text = str(Global.bean_amount[1])
	
	if Global.kernel_amount[0] != 0:
		kernel_lbl_1.text = str(Global.kernel_amount[0])
	else:
		kernel_lbl_1.text = "..."

	if Global.kernel_amount[1] != 0:
		kernel_lbl_2.text = str(Global.kernel_amount[1])
	else:
		kernel_lbl_2.text = "..."
	

	#HEALTHBAR COLORS
	if hp_bar_1.value / hp_bar_1.max_value > 0.5:
		hp_bar_1.get_theme_stylebox("fill").bg_color = Color("72c54e")
		
	if hp_bar_1.value / hp_bar_1.max_value <= 0.5 and hp_bar_1.value / hp_bar_1.max_value > 0.25:
		hp_bar_1.get_theme_stylebox("fill").bg_color = Color("cbac4e")
		
	if hp_bar_1.value / hp_bar_1.max_value <= 0.25:
		hp_bar_1.get_theme_stylebox("fill").bg_color = Color("de6e63")
		
	if hp_bar_2.value / hp_bar_2.max_value > 0.5:
		hp_bar_2.get_theme_stylebox("fill").bg_color = Color("72c54e")
		
	if hp_bar_2.value / hp_bar_2.max_value <= 0.5 and hp_bar_2.value / hp_bar_2.max_value > 0.25:
		hp_bar_2.get_theme_stylebox("fill").bg_color = Color("cbac4e")
		
	if hp_bar_2.value / hp_bar_2.max_value <= 0.25:
		hp_bar_2.get_theme_stylebox("fill").bg_color = Color("de6e63")
		
	if Global.player_1_health <= 0:
		end_of_game.emit(2)
		
	if Global.player_2_health <= 0:
		end_of_game.emit(1)
		
	#SHIELD
	if Global.shield[0] >= 7:
		shield_ui_1.texture = load("res://Graphics/shield icon.png")
	if Global.shield[0] <= 6 and Global.shield[0] >= 4:
		shield_ui_1.texture = load("res://Graphics/shield_broken_1.png")
	if Global.shield[0] <= 3 and Global.shield[0] >= 1:
		shield_ui_1.texture = load("res://Graphics/shield_broken_2.png")
	if Global.shield[0] <= 0:
		shield_ui_1.texture = null
		
	if Global.shield[1] >= 7:
		shield_ui_2.texture = load("res://Graphics/shield icon.png")
	if Global.shield[1] <= 6 and Global.shield[1] >= 4:
		shield_ui_2.texture = load("res://Graphics/shield_broken_1.png")
	if Global.shield[1] <= 3 and Global.shield[1] >= 1:
		shield_ui_2.texture = load("res://Graphics/shield_broken_2.png")
	if Global.shield[1] <= 0:
		shield_ui_2.texture = null
	
	#ABILITIES INPUT
	if Input.is_action_just_pressed("first_1"):
		fruit_ability.emit(1, 1)
	if Input.is_action_just_pressed("first_2"):
		fruit_ability.emit(1, 2)
	if Input.is_action_just_pressed("second_1"):
		fruit_ability.emit(2, 1)
	if Input.is_action_just_pressed("second_2"):
		fruit_ability.emit(2, 2)
	if Input.is_action_just_pressed("third_1"):
		fruit_ability.emit(3, 1)
	if Input.is_action_just_pressed("third_2"):
		fruit_ability.emit(3, 2)
		
	
	#PAPAYA
	if Global.papaya_charging_state[0] != 0 and Global.papaya_seeds_count[0] > 0:
		papaya_lbl_1.show()
		papaya_spr_1.show()
	else:
		papaya_lbl_1.hide()
		papaya_spr_1.hide()
	if Global.papaya_charging_state[1] != 0 and Global.papaya_seeds_count[1] > 0:
		papaya_lbl_2.show()
		papaya_spr_2.show()
	else:
		papaya_lbl_2.hide()
		papaya_spr_2.hide()
		
	papaya_lbl_1.text = str(Global.papaya_seeds_count[0])
	papaya_lbl_2.text = str(Global.papaya_seeds_count[1])
		
func chance_of_spawn_bean():
	if Global.game_time <= 42:
		if Global.game_time % 6 == 1:
			bean_spawn_1 = randi_range(Global.game_time, Global.game_time + 5)
			bean_spawn_2 = randi_range(Global.game_time, Global.game_time + 5)
	if Global.game_time > 42 and Global.game_time <= 120:
		if Global.game_time % 4 == 1:
			bean_spawn_1 = randi_range(Global.game_time, Global.game_time + 3)
			bean_spawn_2 = randi_range(Global.game_time, Global.game_time + 3)
	if Global.game_time > 120:
		if Global.game_time % 3 == 1:
			bean_spawn_1 = randi_range(Global.game_time, Global.game_time + 2)
			bean_spawn_2 = randi_range(Global.game_time, Global.game_time + 2)
			
	if bean_spawn_1 == Global.game_time:
		spawn_bean(1)
	if bean_spawn_2 == Global.game_time:
		spawn_bean(2)
		
func spawn_bean(plr : int):
	var bean_item = bean.instantiate()
	bean_item.plr = plr
	
	var bean_pos_x
	var bean_pos_y
	if plr == 1:
		bean_pos_x = randi_range(8, 480)
		bean_pos_y = randi_range(80, 624)
	else:
		bean_pos_x = randi_range(648, 1120)
		bean_pos_y = randi_range(80, 624)
		
	bean_item.position = Vector2(bean_pos_x, bean_pos_y)
	get_node("/root/main_menu/farmer_frenzy/visual_effects").add_child(bean_item)
	bean_item.collected.connect(award_bean)
	
func award_bean(plr : int):
	Global.bean_amount[plr - 1] += 1
			
	
