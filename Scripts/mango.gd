extends Node2D

@export var MANGO : PackedScene

func shoot_mango(player : int, position_x, position_y):
	var mango_item = MANGO.instantiate()
	mango_item.speed = Global.kernel_speed
	mango_item.plr = player
	mango_item.position.y = position_y + 5
	
	var offset = 80 if player == 1 else -90
	mango_item.position.x = position_x + offset
	get_node("/root/main_menu/farmer_frenzy/visual_effects").add_child(mango_item)
	mango_item.hit.connect(damage)
	
func damage(player_hitted : int):
	if player_hitted == 1:
		Global.player_1_health -= Global.damage["mango"] * Global.player_1_dmg_boost
	else:
		Global.player_2_health -= Global.damage["mango"] * Global.player_2_dmg_boost
