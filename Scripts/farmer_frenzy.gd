extends Node2D

signal go_to_main_menu

@onready var fruit_collection_menu = $beginning_UI/fruit_collection
@onready var fruit_menu = $beginning_UI/fruit_menu
@onready var beginning_UI = $beginning_UI
@onready var visual_effects = $visual_effects

#SLOTS
@onready var plr_1_slot_1_texture = $beginning_UI/first_player/fruit_slots/fruit_1
@onready var plr_1_slot_1_lbl = $beginning_UI/first_player/fruit_slots/fruit_1_label
@onready var plr_1_slot_2_texture = $beginning_UI/first_player/fruit_slots/fruit_2
@onready var plr_1_slot_2_lbl = $beginning_UI/first_player/fruit_slots/fruit_2_label
@onready var plr_1_slot_3_texture = $beginning_UI/first_player/fruit_slots/fruit_3
@onready var plr_1_slot_3_lbl = $beginning_UI/first_player/fruit_slots/fruit_3_label
@onready var plr_1_health = $beginning_UI/first_player/health_bar
@onready var plr_2_health = $beginning_UI/second_player/health_bar

@onready var plr_2_slot_1_texture = $beginning_UI/second_player/fruit_slots/fruit_1
@onready var plr_2_slot_1_lbl = $beginning_UI/second_player/fruit_slots/fruit_1_label
@onready var plr_2_slot_2_texture = $beginning_UI/second_player/fruit_slots/fruit_2
@onready var plr_2_slot_2_lbl = $beginning_UI/second_player/fruit_slots/fruit_2_label
@onready var plr_2_slot_3_texture = $beginning_UI/second_player/fruit_slots/fruit_3
@onready var plr_2_slot_3_lbl = $beginning_UI/second_player/fruit_slots/fruit_3_label
@onready var paused_UI = $beginning_UI/paused_UI
@onready var farmers = $farmers
@onready var map = $beginning_UI/map
@onready var winning_UI = $beginning_UI/winning_UI
@onready var winning_UI_lbl = $beginning_UI/winning_UI/Panel/Label
@onready var pausing_midfight = $beginning_UI/pausing_fight_UI
@onready var game_timer = $beginning_UI/pausing_fight_UI/Timer
@onready var timer_lbl = $beginning_UI/pausing_fight_UI/timer_lbl
@onready var countdown_lbl = $beginning_UI/countdown

func begin_game():
	
	fruit_menu.display_fruit("Mango")
	map.modulate = Color("a2a2a2")
	fruit_menu.show()
	fruit_collection_menu.show()
	plr_1_health.value = Global.player_1_health
	plr_2_health.value = Global.player_2_health
	plr_1_health.get_theme_stylebox("fill").bg_color = Color("72ac4e")
	plr_2_health.get_theme_stylebox("fill").bg_color = Color("72ac4e")
	
func _ready():
	fruit_collection_menu.connect("fruit_pressed", change_fruit_menu_display)
	fruit_menu.connect("slot_selected", change_player_slots)
	fruit_menu.connect("clear_slot", clear_player_slot)
	fruit_menu.connect("requested_go_to_main_menu", paused_mode_menu)
	fruit_menu.connect("start_game", begin_farmer_fight)
	paused_UI.connect("approve_return_to_main_menu", quit_menu)
	paused_UI.connect("denied_return_to_main_menu", not_go_to_quit_menu)
	beginning_UI.connect("end_of_game", game_won)
	pausing_midfight.connect("game_paused", paused_midgame)
	pausing_midfight.connect("leave_game", quit_menu)
	
func change_fruit_menu_display(fruit : String):
	fruit_menu.display_fruit(fruit)
	
func change_player_slots(slot, plr, fruit_var):
	fruit_menu.change_slot_color(slot, plr)
	if plr == 1:
		if slot == 1:
			plr_1_slot_1_texture.texture = load("res://Graphics/" + fruit_var + ".png")
			plr_1_slot_1_lbl.text = str(Global.fruit_bean_costs[fruit_var])
		if slot == 2:
			plr_1_slot_2_texture.texture = load("res://Graphics/" + fruit_var + ".png")
			plr_1_slot_2_lbl.text = str(Global.fruit_bean_costs[fruit_var])
		if slot == 3:
			plr_1_slot_3_texture.texture = load("res://Graphics/" + fruit_var + ".png")
			plr_1_slot_3_lbl.text = str(Global.fruit_bean_costs[fruit_var])
		Global.player_1_fruits[slot - 1] = fruit_var
	else:
		if slot == 1:
			plr_2_slot_1_texture.texture = load("res://Graphics/" + fruit_var + ".png")
			plr_2_slot_1_lbl.text = str(Global.fruit_bean_costs[fruit_var])
		if slot == 2:
			plr_2_slot_2_texture.texture = load("res://Graphics/" + fruit_var + ".png")
			plr_2_slot_2_lbl.text = str(Global.fruit_bean_costs[fruit_var])
		if slot == 3:
			plr_2_slot_3_texture.texture = load("res://Graphics/" + fruit_var + ".png")
			plr_2_slot_3_lbl.text = str(Global.fruit_bean_costs[fruit_var])
		Global.player_2_fruits[slot - 1] = fruit_var

func clear_player_slot(slot, plr):
	fruit_menu.remove_color_player_slot(slot, plr)
	if plr == 1:
		if slot == 1:
			plr_1_slot_1_texture.texture = null
			plr_1_slot_1_lbl.text = "0"
		if slot == 2:
			plr_1_slot_2_texture.texture = null
			plr_1_slot_2_lbl.text = "0"
		if slot == 3:
			plr_1_slot_3_texture.texture = null
			plr_1_slot_3_lbl.text = "0"
		Global.player_1_fruits[slot - 1] = ""
	else:
		if slot == 1:
			plr_2_slot_1_texture.texture = null
			plr_2_slot_1_lbl.text = "0"
		if slot == 2:
			plr_2_slot_2_texture.texture = null
			plr_2_slot_2_lbl.text = "0"
		if slot == 3:
			plr_2_slot_3_texture.texture = null
			plr_2_slot_3_lbl.text = "0"
		Global.player_2_fruits[slot - 1] = ""

func paused_mode_menu():
	paused_UI.show()
	get_tree().paused = true

func quit_menu():
	for i in range(2):
		for j in range(3):
			clear_player_slot(j+1, i+1)
	paused_UI.hide()
	pausing_midfight.hide()
	fruit_menu.display_fruit("Mango")
	Global.player_1_fruits = ["","",""]
	Global.player_2_fruits = ["","",""]
	go_to_main_menu.emit()
	Global.player_1_health = 50
	Global.player_2_health = 50
	farmers.hide()
	game_timer.stop()
	Global.game_time = 0
	timer_lbl.text = "00:00"
	Global.is_in_farmer_fight = false
	

func not_go_to_quit_menu():
	paused_UI.hide()
	get_tree().paused = false

func begin_farmer_fight():
	map.modulate = Color("ffffff")
	fruit_menu.hide()
	fruit_collection_menu.hide()
	farmers.show()
	pausing_midfight.show()
	farmers.set_up_farmers()
	
	countdown_lbl.show()
	countdown_lbl.text = "3!"
	await Global.wait(1)
	countdown_lbl.text = "2!"
	await Global.wait(1)
	countdown_lbl.text = "1!"
	await Global.wait(1)
	countdown_lbl.text = "FIGHT!"
	await Global.wait(1)
	#YOU SHOULD ADD THE COUNTDOWN TIMER
	Global.is_in_farmer_fight = true
	game_timer.start()
	countdown_lbl.hide()
	
func game_won(plr_won : int):
	get_tree().paused = true
	Global.is_in_farmer_fight = false
	winning_UI.show()
	if plr_won == 1:
		winning_UI_lbl.text = Global.player_name_1 + " WON THE FIGHT!"
		Global.player_1_wins += 1
	else:
		winning_UI_lbl.text = Global.player_name_2 + " WON THE FIGHT!"
		Global.player_2_wins += 1
	
	await Global.wait(2)
	
	winning_UI.hide()
	for child in visual_effects.get_children():
		child.queue_free()
	quit_menu()
	
func paused_midgame(on_or_off : int):
	pass
