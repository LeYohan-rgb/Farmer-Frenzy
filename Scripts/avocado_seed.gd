extends Area2D

var velocity : float = 0.0
var my_gravity : float = required_acceleration(1)
signal hit_ground
@export var desired_position : Vector2
var explode = false
@onready var anim_spr = $AnimatedSprite2D
@onready var my_spr = $Sprite2D

func _ready():
	pass
	
func required_acceleration(time: float) -> float:
	var distance = 623.0
	return 2.0 * distance / (time * time)
	

	
	
func _physics_process(delta: float) -> void:
	if !Global.is_in_farmer_fight:
		return

	if position.y < desired_position.y - 47.5:
		velocity += my_gravity * delta
		position.y += velocity * delta
	else:
		if !explode:
			explode = true
			guacamole_explosion()
			
func guacamole_explosion():
	my_spr.hide()
	anim_spr.play("default")
	await anim_spr.animation_finished
	queue_free()
	
