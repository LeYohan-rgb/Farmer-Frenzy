extends Area2D

@export var plr : int
@onready var my_timer = $Timer
signal heal

func _ready():
	my_timer.start(10)
	my_timer.timeout.connect(die_now)
	
func die_now():
	queue_free()
	
func _on_body_entered(body: CharacterBody2D) -> void:
	heal.emit(body.plr, Global.damage["guava"])
	queue_free()
