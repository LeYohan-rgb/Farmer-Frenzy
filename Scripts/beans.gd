extends Area2D

signal collected(collector : int)

@export var plr : int


func _on_body_entered(body: CharacterBody2D) -> void:
	collected.emit(plr)
	queue_free()
