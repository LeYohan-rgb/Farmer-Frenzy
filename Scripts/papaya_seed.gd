extends Area2D


signal hit(player_hit : int, damage_dealt : float)

@export var speed : int
@onready var spr = $Sprite2D
@export var plr : int 
@export var damage : float

var position_shooting : Vector2
var is_reflected := false

func _ready() -> void:
	if plr == 1:
		position_shooting = Vector2.RIGHT
	elif plr == 2:
		position_shooting = Vector2.LEFT
		spr.scale.x *= -1
		
func _physics_process(delta: float) -> void:
	if plr != 1 and plr != 2:
		return
		
	position += position_shooting * speed * delta
	
	if is_reflected:
		rotation = position_shooting.angle()
		
		#IF OFF-LIMITS, DELETE
	if position.x > 1280 or position.x < -80:
		queue_free()
		
func rotate_seed(pos: Vector2) -> void:
	position_shooting = (pos - position).normalized()
	is_reflected = true
	rotation = position_shooting.angle()
			
func _on_body_entered(body) -> void:
	if is_instance_valid(body) and body is CharacterBody2D:
		hit.emit(body.plr, damage)
		queue_free()
		
	if is_instance_valid(body) and body is StaticBody2D and body.is_in_group("hitable") and body.plr != plr:
		if plr == 1:
			body.receive_damage(damage * Global.player_1_dmg_boost, plr)
		else:
			body.receive_damage(damage * Global.player_2_dmg_boost, plr)
		queue_free()
