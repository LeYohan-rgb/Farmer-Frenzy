extends Node2D

@export var COCONUT_SHIELD : PackedScene
@onready var timer = $Timer
var coconut_time_duration : float = 10.0
var track_coconut

signal lower_speed

func perform_coconut(plr : int, x_coord : float, y_coord : float) -> void:
	await get_tree().physics_frame
	timer.start(coconut_time_duration)
	timer.timeout.connect(destroy_coconut_mode.bind(plr, x_coord, y_coord))
	Global.coconut_mode[plr - 1] = true
	summon_shield(plr, x_coord, y_coord)

func summon_shield(plr, x_coord, y_coord):
	Global.coconut_on[plr - 1] = true
	lower_speed.emit()
	var coconut_shield = COCONUT_SHIELD.instantiate()
	track_coconut = coconut_shield
	coconut_shield.plr = plr
	
	var offset = 50 if plr == 1 else -50
	coconut_shield.position = Vector2(offset, 0)
	
	var player_node
	if plr == 1:
		player_node = get_node("/root/main_menu/farmer_frenzy/farmers/farmer")
	else:
		player_node = get_node("/root/main_menu/farmer_frenzy/farmers/farmer2")
	player_node.add_child(coconut_shield)

func activate_coconut_shield(plr : int, x_coord : float, y_coord : float) -> void:
	if Global.coconut_on[plr - 1]:
		track_coconut.queue_free()
		Global.coconut_on[plr - 1] = false
		lower_speed.emit()
	else:
		summon_shield(plr, x_coord, y_coord)

func destroy_coconut_mode(plr, x_coord, y_coord):
	Global.coconut_mode[plr - 1] = false
	if Global.coconut_on[plr - 1]:
		track_coconut.queue_free()
		Global.coconut_on[plr - 1] = false
		lower_speed.emit()
