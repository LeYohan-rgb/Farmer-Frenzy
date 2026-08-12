extends Node2D

@export var COCONUT_SHIELD : PackedScene

func perform_coconut(plr : int, x_coord : float, y_coord : float) -> void:
	Global.coconut_mode[plr - 1] = true
	summon_shield(plr, x_coord, y_coord)

func summon_shield(plr, x_coord, y_coord):
	Global.coconut_on[plr - 1] = true
	var coconut_shield = COCONUT_SHIELD.instantiate()
	coconut_shield.plr = plr
	
	var offset = 50 if plr == 1 else -50
	coconut_shield.position = Vector2(offset, 0)
	
	var player_node
	if plr == 1:
		player_node = get_node("/root/main_menu/farmer_frenzy/farmers/farmer")
	else:
		player_node = get_node("/root/main_menu/farmer_frenzy/farmers/farmer2")
	player_node.add_child(coconut_shield)
