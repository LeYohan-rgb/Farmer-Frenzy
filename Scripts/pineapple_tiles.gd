extends Area2D

class_name Pineapple

@export var is_pineapple : bool
@export var plr : int
@export var row_type : int
@onready var my_timer = $Timer
var wait_time : float = 15.0

func _ready():
	my_timer.start(wait_time)
	my_timer.timeout.connect(time_ended)

func time_ended():
	Global.pineapple_is_on[plr - 1] = false
	queue_free()
	
#func _on_body_entered(body: CharacterBody2D) -> void:
	#body.speed = 100
#
#
#func _on_body_exited(body: CharacterBody2D) -> void:
	#body.speed = 275
