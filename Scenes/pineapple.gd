extends Node2D

@export var PINEAPPLE : PackedScene

func perform_pineapple(plr, x_coord, y_coord):
	if Global.pineapple_is_on[plr + 1]:
		return
	
	#PINEAPPLE OUT OF BOUNDS
	if y_coord < 136 or y_coord > 520:
		return
		
	if plr == 1:
		var pineapple_tile = PINEAPPLE.instantiate()
		pineapple_tile.plr = plr
		pineapple_tile.position.x = 0 if plr == 1 else 640
		pineapple_tile.position.y = return_pineapple_pos(y_coord)
		
		
	else:
		pass

func return_pineapple_pos(y_coord : float) -> float:
	if y_coord >= 136 and y_coord < 200:
		return 136
	if y_coord >= 136 and y_coord < 200:
		return 136
	if y_coord >= 136 and y_coord < 200:
		return 136
	if y_coord >= 136 and y_coord < 200:
		return 136
	if y_coord >= 136 and y_coord < 200:
		return 136
	return 0.0
	
#136 - 200 (FAR)
#200 - 328 (UPPER)
#328 - 392 (CENTER)
#392 - 456 (DOWN)
#456 - 520 (FAR DOWN)

#func shoot_mango(player : int, position_x, position_y):
	#var damage_calculated : float
	#if player == 1:
		#damage_calculated = 1.0 + position_x / 256.0
	#else:
		#damage_calculated = 5.5 - position_x / 256.0
	#var mango_item = MANGO.instantiate()
	#mango_item.speed = Global.speed["mango"]
	#mango_item.plr = player
	#mango_item.position.y = position_y + 5
	#mango_item.damage = damage_calculated
	#
	#var offset = 60 if player == 1 else -60
	#mango_item.position.x = position_x + offset
	#get_node("/root/main_menu/farmer_frenzy/visual_effects").add_child(mango_item)
	#throw_sound.play()
	#mango_item.hit.connect(damage)
