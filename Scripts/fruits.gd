extends Node2D

signal papaya_timer_started(on_or_off : int)

@export var plr : int
@onready var mango = $mango
@onready var watermelon = $watermelon
@onready var papaya = $papaya
@onready var pineapple = $pineapple
@onready var guava = $guava
@onready var avocado = $avocado
@onready var cocoa = $cocoa
@onready var coconut = $coconut
@onready var papaya_timer = $papaya/Timer
signal shoot_melon_with_coords(fruit : String)

func _process(delta: float) -> void:
	if !Global.is_in_farmer_fight:
		return
		
	if Global.is_fruit_in_party("Watermelon") and Global.watermelon_is_alive[plr - 1]:
		if Input.is_action_just_pressed(Global.num_to_ordinal(Global.fruit_to_slot("Watermelon", plr))+"_"+str(plr)):
			shoot_melon_with_coords.emit("watermelon")
			Global.watermelon_is_alive[plr - 1] = false
		
	#START CHARGING
	if plr == 1:
		pass
		
	if Global.is_fruit_in_party("Papaya") and Global.papaya_charging_state[plr - 1] == 2:
		if Input.is_action_just_pressed(Global.num_to_ordinal(Global.fruit_to_slot("Papaya", plr))+"_"+str(plr)):
			papaya.timer_ended()
			papaya_timer_started.emit(1)
			Global.papaya_charging_state[plr - 1] = 3
			
	if Global.is_fruit_in_party("Papaya") and (Global.papaya_charging_state[plr - 1] != 0 and Global.papaya_charging_state[plr - 1] != 2 and Global.papaya_charging_state[plr - 1] != 3):
			
		if Input.is_action_just_pressed(Global.num_to_ordinal(Global.fruit_to_slot("Papaya", plr))+"_"+str(plr)):
			papaya.timer_started()
			papaya_timer_started.emit(0)
			await get_tree().physics_frame
			Global.papaya_charging_state[plr -1 ] = 2
			Global.can_shield[plr - 1] = false
			
			
		
			
func perform(fruit : String, x_coord : float = 0.0, y_coord : float = 0.0):
	if fruit == "Mango":
		mango.perform_mango(plr)
	if fruit == "Watermelon":
		watermelon.perform_watermelon(plr, x_coord, y_coord)
	if fruit == "Papaya":
		papaya.perform_papaya(plr)
	if fruit == "Pineapple":
		pineapple.perform_pineapple(plr, x_coord, y_coord)
	if fruit == "Guava":
		guava.perform_guava(plr, x_coord, y_coord)
	if fruit == "Avocado":
		avocado.perform_avocado(plr, x_coord, y_coord)
	if fruit == "Cocoa":
		cocoa.perform_cocoa(plr, x_coord, y_coord)
	if fruit == "Coconut":
		coconut.perform_coconut(plr, x_coord, y_coord)
		
		
