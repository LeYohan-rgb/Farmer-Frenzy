extends Area2D

@export var plr : int
@onready var my_timer = $Timer
@onready var my_spr = $Sprite2D
signal heal

func _ready():
	my_timer.start(10 - 0.25)
	var tween_2 = create_tween()
	tween_2.set_trans(Tween.TRANS_LINEAR)
	tween_2.tween_property(my_spr, "modulate:a", 1.0, 0.25)
	my_timer.timeout.connect(die_now)
	
func die_now():
	var tween_2 = create_tween()
	tween_2.set_trans(Tween.TRANS_LINEAR)
	tween_2.tween_property(my_spr, "modulate:a", 0.0, 0.25)
	await tween_2.finished
	queue_free()
	
func _on_body_entered(body: CharacterBody2D) -> void:
	heal.emit(body.plr, Global.damage["guava"])
	queue_free()
