extends Area2D

signal hit(player_hit : int)

@export var speed : int
@onready var spr = $Sprite2D
@export var plr : int
@export var damage : float

#PROJECTILE CODE
var position_shooting : Vector2

func _ready() -> void:
	damage = Global.damage["kernel"]
	if plr == 1:
		position_shooting = Vector2.RIGHT
	elif plr == 2:
		position_shooting = Vector2.LEFT

	
func _physics_process(delta: float) -> void:
	if plr != 1 and plr != 2:
		return
		
	# Move in the current direction
	position += position_shooting * speed * delta

	# Rotate to face movement direction
	rotation = position_shooting.angle()

	# Delete when outside the screen
	if position.x > 1280 or position.x < -80:
		queue_free()

func rotate_seed(pos: Vector2) -> void:
	position_shooting = (pos - position).normalized()
	rotation = position_shooting.angle()
			
func _on_body_entered(body) -> void:
	if is_instance_valid(body) and body is CharacterBody2D:
		hit.emit(body.plr)
		queue_free()
		
	if is_instance_valid(body) and body is StaticBody2D and body.is_in_group("hitable") and body.plr != plr:
		if plr == 1:
			body.receive_damage(damage * Global.player_1_dmg_boost, plr)
		else:
			body.receive_damage(damage * Global.player_2_dmg_boost, plr)
		queue_free()
	
