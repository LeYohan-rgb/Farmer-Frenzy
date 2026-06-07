extends Area2D

@export var plr : int = 0
signal hit(dmg : int)

@onready var spr = $Sprite2D

func _ready() -> void:
	if plr == 2:
		spr.scale.x *= -1



func _on_body_entered(body: CharacterBody2D) -> void:
		
	hit.emit(body.plr)
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	print("hi?")
	hit.emit(area.damage)
	area.queue_free()
