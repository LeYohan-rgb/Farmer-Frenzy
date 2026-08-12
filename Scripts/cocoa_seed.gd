extends Area2D

@export var plr : int
@export var speed : float = Global.speed["cocoa_seed"]#1800
@onready var spr = $Sprite2D
var damage : float = Global.damage["cocoa_seed"]
@onready var hit_sfx = $hit

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


func _on_body_entered(body) -> void:
	hit_sfx.play()
	if body is CharacterBody2D and body.plr != plr:
		body.receive_damage(damage, plr)
		queue_free()
	if body is StaticBody2D and body.is_in_group("hitable"):
		body.receive_damage(damage, plr)
		queue_free()
