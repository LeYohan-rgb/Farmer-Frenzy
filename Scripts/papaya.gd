extends Node2D

@export var PAPAYA : PackedScene
@onready var timer = $Timer


func timer_started():
	timer.start()
	
func timer_ended():
	timer.stop()
	
func perform_papaya(plr : int):
	await get_tree().physics_frame
	Global.papaya_charging_state[plr - 1] = 1
	print(Global.papaya_charging_state[plr -1 ])
	
