extends Area2D

class_name Pineapple

@export var damage : float
@export var is_pineapple : bool
@export var plr : int
@export var row_type : int
@onready var my_timer = $Timer
var wait_time : float = 15.0
@onready var my_spr = $Sprite2D

func _ready():
	my_timer.start(wait_time - 0.5)
	var tween_2 = create_tween()
	tween_2.set_trans(Tween.TRANS_LINEAR)
	tween_2.tween_property(my_spr, "modulate:a", 1.0, 0.5)
	my_timer.timeout.connect(time_ended)

func time_ended():
	var tween_2 = create_tween()
	tween_2.set_trans(Tween.TRANS_LINEAR)
	tween_2.tween_property(my_spr, "modulate:a", 0.0, 0.5)
	await tween_2.finished
	Global.pineapple_is_on[plr - 1] = false
	queue_free()
	
