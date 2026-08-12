extends Node2D

@export var CHOCOLATE_FARMER : PackedScene

func perform_cocoa(plr : int, x_coord : float, y_coord : float) -> void:
	var farmer_1 = CHOCOLATE_FARMER.instantiate()
	var farmer_2 = CHOCOLATE_FARMER.instantiate()
	var farmer_3 = CHOCOLATE_FARMER.instantiate()
	
	farmer_1.plr = plr
	farmer_2.plr = plr
	farmer_3.plr = plr
	farmer_1.clone_number = 1
	farmer_2.clone_number = 2
	farmer_3.clone_number = 3
	
	farmer_1.position = Vector2(return_chocolate_coord(x_coord, plr)[0], 232)
	farmer_2.position = Vector2(return_chocolate_coord(x_coord, plr)[0], 360)
	farmer_3.position = Vector2(return_chocolate_coord(x_coord, plr)[0], 488)
	
	farmer_1.column_number = return_chocolate_coord(x_coord, plr)[1]
	farmer_2.column_number = return_chocolate_coord(x_coord, plr)[1]
	farmer_3.column_number = return_chocolate_coord(x_coord, plr)[1]
	
	remove_player_health(return_chocolate_coord(x_coord, plr)[1], plr)
	
	get_node("/root/main_menu/farmer_frenzy/visual_effects").add_child(farmer_1)
	get_node("/root/main_menu/farmer_frenzy/visual_effects").add_child(farmer_2)
	get_node("/root/main_menu/farmer_frenzy/visual_effects").add_child(farmer_3)
	
	
func return_chocolate_coord(x_coord, plr) -> Array:
	if plr == 1:
		if x_coord >= 0 and x_coord < 128:
			return [64.0, 1]
		if x_coord >= 128 and x_coord < 256:
			return [192.0, 2]
		if x_coord >= 256 and x_coord < 384:
			return [320.0, 3]
		if x_coord >= 384:
			return [448.0, 4]
	else:
		if x_coord >= 640 and x_coord < 768:
			return [704.0, 1]
		if x_coord >= 768 and x_coord < 896:
			return [832.0, 2]
		if x_coord >= 896 and x_coord < 1024:
			return [960.0, 3]
		if x_coord >= 1024:
			return [1088.0, 4]
	return [0.0, 1]
	
func remove_player_health(column : float, player : int):
	if column == 1:
		if player == 1:
			Global.player_1_health -= Global.maximum_health / 8.0
		else:
			Global.player_2_health -= Global.maximum_health / 8.0
	if column == 2:
		if player == 1:
			Global.player_1_health -= Global.maximum_health / 9.6
		else:
			Global.player_2_health -= Global.maximum_health / 9.6
	if column == 3:
		if player == 1:
			Global.player_1_health -= Global.maximum_health / 12
		else:
			Global.player_2_health -= Global.maximum_health / 12
	if column == 4:
		if player == 1:
			Global.player_1_health -= Global.maximum_health / 16.0
		else:
			Global.player_2_health -= Global.maximum_health / 16.0
