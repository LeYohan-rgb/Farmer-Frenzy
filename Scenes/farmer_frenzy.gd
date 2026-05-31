extends Node2D

signal go_to_main_menu

@onready var fruit_collection_menu = $beginning_UI/fruit_collection
@onready var fruit_menu = $beginning_UI/fruit_menu

#SLOTS
@onready var plr_1_slot_1_texture = $beginning_UI/first_player/fruit_slots/fruit_1
@onready var plr_1_slot_1_lbl = $beginning_UI/first_player/fruit_slots/fruit_1_label
@onready var plr_1_slot_2_texture = $beginning_UI/first_player/fruit_slots/fruit_2
@onready var plr_1_slot_2_lbl = $beginning_UI/first_player/fruit_slots/fruit_2_label
@onready var plr_1_slot_3_texture = $beginning_UI/first_player/fruit_slots/fruit_3
@onready var plr_1_slot_3_lbl = $beginning_UI/first_player/fruit_slots/fruit_3_label

@onready var plr_2_slot_1_texture = $beginning_UI/second_player/fruit_slots/fruit_1
@onready var plr_2_slot_1_lbl = $beginning_UI/second_player/fruit_slots/fruit_1_label
@onready var plr_2_slot_2_texture = $beginning_UI/second_player/fruit_slots/fruit_2
@onready var plr_2_slot_2_lbl = $beginning_UI/second_player/fruit_slots/fruit_2_label
@onready var plr_2_slot_3_texture = $beginning_UI/second_player/fruit_slots/fruit_3
@onready var plr_2_slot_3_lbl = $beginning_UI/second_player/fruit_slots/fruit_3_label
@onready var paused_UI = $beginning_UI/paused_UI

func begin_game():
	fruit_menu.display_fruit("Mango")

func _ready():
	fruit_collection_menu.connect("fruit_pressed", change_fruit_menu_display)
	fruit_menu.connect("slot_selected", change_player_slots)
	fruit_menu.connect("clear_slot", clear_player_slot)
	fruit_menu.connect("requested_go_to_main_menu", paused_mode_menu)
	paused_UI.connect("approve_return_to_main_menu", quit_menu)
	paused_UI.connect("denied_return_to_main_menu", not_go_to_quit_menu)
	
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
	fruit_menu.display_fruit("Mango")
	Global.player_1_fruits = ["","",""]
	Global.player_2_fruits = ["","",""]
	go_to_main_menu.emit()
	

func not_go_to_quit_menu():
	paused_UI.hide()
	get_tree().paused = false
