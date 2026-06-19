extends Node2D

signal shoot_papaya_with_coords(fruit : String)
signal shooting_mango_terminated
@export var PAPAYA : PackedScene
@onready var timer = $Timer
@onready var small_throw = $small_throw
@onready var impact_sound = $impact_sound


func timer_started():
	timer.start()
	
func timer_ended():
	timer.stop()
	
func perform_papaya(plr : int):
	await get_tree().physics_frame
	Global.papaya_seeds_count[plr -1 ] = 40
	Global.papaya_charging_state[plr - 1] = 1
	
func perform_shooting_papaya(num_of_papayas : int, plr : int):
	for i in range(num_of_papayas):
		if !Global.is_in_farmer_fight:
			Global.papaya_seeds_count[plr - 1] = 0
			Global.papaya_charging_state[plr - 1] = 0
			return
		shoot_papaya_with_coords.emit("papaya")
		Global.papaya_seeds_count[plr - 1] -= 1
		await Global.wait(0.075)
	shooting_mango_terminated.emit()
		
func shoot_papaya(player : int, position_x, position_y):
	var desired_scale : float
	if player == 1:
		desired_scale = 1.0 + position_x / 512.0
	else:
		desired_scale = 2.0 - (position_x - 640.0) / 512.0
	var papaya_item = PAPAYA.instantiate()
	papaya_item.scale = Vector2(desired_scale, desired_scale)
	papaya_item.speed = Global.speed["papaya"]
	papaya_item.plr = player
	papaya_item.position.y = position_y + 5
	papaya_item.damage = Global.damage["papaya"]
	
	var offset = 60 if player == 1 else -60
	papaya_item.position.x = position_x + offset
	get_node("/root/main_menu/farmer_frenzy/visual_effects").add_child(papaya_item)
	small_throw.play()
	papaya_item.hit.connect(damage)
	
func damage(player_hitted : int, damage_dealt : float):
	impact_sound.play()
	if player_hitted == 1:
		Global.player_1_health -= damage_dealt * Global.player_1_dmg_boost
	else:
		Global.player_2_health -= damage_dealt * Global.player_2_dmg_boost

func shoot_papayas_with_coords(x, y, plr : int):
	shoot_papaya(plr, x, y)
