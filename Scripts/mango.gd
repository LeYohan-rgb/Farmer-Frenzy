extends Node2D

signal shoot_with_coords(str : String)
@export var MANGO : PackedScene
var coord_x
var coord_y

func perform_mango(player : int):
	Global.can_shield[player - 1] = false
	for i in range(5):
		shoot_with_coords.emit("mango")
		await Global.wait(0.333)
	Global.can_shield[player - 1] = true
		
func shoot_mango(player : int, position_x, position_y):
	var damage_calculated : float
	if player == 1:
		damage_calculated = 1.0 + position_x / 256.0
	else:
		damage_calculated = 5.5 - position_x / 256.0
	var mango_item = MANGO.instantiate()
	mango_item.speed = Global.speed["mango"]
	mango_item.plr = player
	mango_item.position.y = position_y + 5
	mango_item.damage = damage_calculated
	
	var offset = 60 if player == 1 else -60
	mango_item.position.x = position_x + offset
	get_node("/root/main_menu/farmer_frenzy/visual_effects").add_child(mango_item)
	mango_item.hit.connect(damage)
	
func damage(player_hitted : int, damage_dealt : float):
	if player_hitted == 1:
		Global.player_1_health -= damage_dealt * Global.player_1_dmg_boost
	else:
		Global.player_2_health -= damage_dealt * Global.player_2_dmg_boost

func shoot_mango_with_coords(x, y, plr : int):
	shoot_mango(plr, x, y)
