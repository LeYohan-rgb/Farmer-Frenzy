extends Node2D

signal slot_selected(slot : int, plr : int, fruit_var : String)
signal clear_slot(slot : int, plr : int)
signal requested_go_to_main_menu

var fruit_var = "Mango"
@onready var fruit_lbl = $fruit_lbl
@onready var fruit_img = $fruit_display
@onready var bean_price_lbl = $bean_price
@onready var money_price_lbl = $money_price
@onready var fruit_desc = $description
@onready var play_btn = $play_btn
@onready var warning_label = $warning_pre_play

#SLOTS
@onready var slot_1_1 = $slot_1_1
@onready var slot_2_1 = $slot_2_1
@onready var slot_3_1 = $slot_3_1
@onready var slot_1_2 = $slot_1_2
@onready var slot_2_2 = $slot_2_2
@onready var slot_3_2 = $slot_3_2


func display_fruit(fruit : String):
	fruit_var = fruit
	fruit_lbl.text = fruit.to_upper()
	fruit_img.texture = load("res://Graphics/" + fruit + ".png")
	bean_price_lbl.text = str(Global.fruit_bean_costs[fruit])
	money_price_lbl.text = str(Global.fruit_prices[fruit])
	fruit_desc.text = Global.fruit_descriptions[fruit]
	
func change_slot_color(slot, plr):
	if plr == 1:
		if slot == 1:
			slot_1_1.get_theme_stylebox("normal").bg_color = Color("d9726a")
		if slot == 2:
			slot_2_1.get_theme_stylebox("normal").bg_color = Color("d9726a")
		if slot == 3:
			slot_3_1.get_theme_stylebox("normal").bg_color = Color("d9726a")
	else:
		if slot == 1:
			slot_1_2.get_theme_stylebox("normal").bg_color = Color("1e8cbc")
		if slot == 2:
			slot_2_2.get_theme_stylebox("normal").bg_color = Color("1e8cbc")
		if slot == 3:
			slot_3_2.get_theme_stylebox("normal").bg_color = Color("1e8cbc")
			
func remove_color_player_slot(slot, plr):
	if plr == 1:
		if slot == 1:
			slot_1_1.get_theme_stylebox("normal").bg_color = Color("675743")
		if slot == 2:
			slot_2_1.get_theme_stylebox("normal").bg_color = Color("675743")
		if slot == 3:
			slot_3_1.get_theme_stylebox("normal").bg_color = Color("675743")
	else:
		if slot == 1:
			slot_1_2.get_theme_stylebox("normal").bg_color = Color("675743")
		if slot == 2:
			slot_2_2.get_theme_stylebox("normal").bg_color = Color("675743")
		if slot == 3:
			slot_3_2.get_theme_stylebox("normal").bg_color = Color("675743")


func _on_slot_1_1_pressed() -> void:
	for i in range(3):
		if Global.player_1_fruits[i] == fruit_var and i != 0:
			clear_slot.emit(i+1, 1)
			
	if Global.player_1_fruits[0] == "":
		slot_selected.emit(1, 1, fruit_var)
	else:
		clear_slot.emit(1, 1)


func _on_slot_2_1_pressed() -> void:
	for i in range(3):
		if Global.player_1_fruits[i] == fruit_var and i != 1:
			clear_slot.emit(i+1, 1)
			
	if Global.player_1_fruits[1] == "":
		slot_selected.emit(2, 1, fruit_var)
	else:
		clear_slot.emit(2, 1)


func _on_slot_3_1_pressed() -> void:
	for i in range(3):
		if Global.player_1_fruits[i] == fruit_var and i != 2:
			clear_slot.emit(i+1, 1)
			
	if Global.player_1_fruits[2] == "":
		slot_selected.emit(3, 1, fruit_var)
	else:
		clear_slot.emit(3, 1)


func _on_slot_1_2_pressed() -> void:
	for i in range(3):
		if Global.player_2_fruits[i] == fruit_var and i != 0:
			clear_slot.emit(i+1, 2)
			
	if Global.player_2_fruits[0] == "":
		slot_selected.emit(1, 2, fruit_var)
	else:
		clear_slot.emit(1, 2)


func _on_slot_2_2_pressed() -> void:
	for i in range(3):
		if Global.player_2_fruits[i] == fruit_var and i != 1:
			clear_slot.emit(i+1, 2)
			
	if Global.player_2_fruits[1] == "":
		slot_selected.emit(2, 2, fruit_var)
	else:
		clear_slot.emit(2, 2)


func _on_slot_3_2_pressed() -> void:
	for i in range(3):
		if Global.player_2_fruits[i] == fruit_var and i != 2:
			clear_slot.emit(i+1, 2)
			
	if Global.player_2_fruits[2] == "":
		slot_selected.emit(3, 2, fruit_var)
	else:
		clear_slot.emit(3, 2)


func _on_go_back_btn_pressed() -> void:
	requested_go_to_main_menu.emit()


func _on_play_btn_pressed() -> void:
	var is_all_fruits_completed = true
	var all_player_fruits = Global.player_1_fruits + Global.player_2_fruits
	for i in range(6):
		if all_player_fruits[i] == "":
			is_all_fruits_completed = false
	
	if is_all_fruits_completed:
		print("yess")
	else:
		await denied_play_game()
		
func denied_play_game():
	var tween = create_tween()
	# Fade in
	tween.tween_property(warning_label, "modulate:a", 1.0, 0.5)
	tween.tween_interval(1.5)
	tween.tween_property(warning_label, "modulate:a", 0.0, 0.5)
