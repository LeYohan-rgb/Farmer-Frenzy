extends Area2D

@export var plr : int
@export var speed : float = 0.0#1800
@onready var spr = $Sprite2D

var position_shooting

func _physics_process(delta: float) -> void:
	if plr != 1 and plr != 2:
		return
		
	if plr == 1:
		position += position_shooting * speed * delta
		
		#IF OFF-LIMITS, DELETE
		if position.x > 1280:
			queue_free()
	else:
		spr.rotation_degrees = 270
		position -= position_shooting * speed * delta
		
		#IF OFF-LIMITS, DELETE
		if position.x < -80:
			queue_free()

func rotate_seed(pos : Vector2):
	if plr == 1:
		position_shooting = (pos - position).normalized()
	else:
		position_shooting = (position - pos).normalized()
	rotation = position_shooting.angle()
