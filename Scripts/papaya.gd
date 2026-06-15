extends Node2D

signal shoot_papaya_with_coords(fruit : String)
@export var PAPAYA : PackedScene
@onready var timer = $Timer


func timer_started():
	timer.start()
	
func timer_ended():
	timer.stop()
	
func perform_papaya(plr : int):
	await get_tree().physics_frame
	Global.papaya_charging_state[plr - 1] = 1
	
func perform_shooting_papaya(num_of_papayas : int, plr : int):
	for i in range(num_of_papayas):
		shoot_papaya_with_coords.emit("papaya")
		Global.papaya_seeds_count[plr - 1] -= 1
		await Global.wait(0.15)
		
		
func shoot_papaya(player : int, position_x, position_y):
	var papaya_item = PAPAYA.instantiate()
	papaya_item.speed = Global.speed["mango"]
	papaya_item.plr = player
	papaya_item.position.y = position_y + 5
	papaya_item.damage = Global.damage["papaya"]
	
	var offset = 60 if player == 1 else -60
	papaya_item.position.x = position_x + offset
	get_node("/root/main_menu/farmer_frenzy/visual_effects").add_child(papaya_item)
	papaya_item.hit.connect(damage)
	
func damage(player_hitted : int, damage_dealt : float):
	if player_hitted == 1:
		Global.player_1_health -= damage_dealt * Global.player_1_dmg_boost
	else:
		Global.player_2_health -= damage_dealt * Global.player_2_dmg_boost

func shoot_papayas_with_coords(x, y, plr : int):
	shoot_papaya(plr, x, y)
