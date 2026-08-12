extends Node2D

@export var COCONUT_SHIELD : PackedScene

func perform_coconut(plr : int, x_coord : float, y_coord : float) -> void:
	Global.coconut_mode[plr - 1] = true
	summon_shield(plr, x_coord, y_coord)

func summon_shield(plr, x_coord, y_coord):
	Global.coconut_on[plr - 1] = true
	pass
