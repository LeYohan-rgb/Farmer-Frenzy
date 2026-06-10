extends Area2D

signal hit(player_hit : int, damage_dealt : float)

@export var speed : int
@onready var spr = $Sprite2D
@export var plr : int 
@export var damage : float
@export var my_angle : float = 0.0


func _ready() -> void:
	damage = Global.damage["watermelon_seed"]
	if plr == 2:
		spr.scale.x *= -1
		
func _physics_process(delta: float) -> void:
	var direction_angle : float = deg_to_rad(my_angle)
	
	if plr != 1 and plr != 2:
		return
	
	if plr == 1:
		position.x += cos(direction_angle) * speed * delta
		position.y -= sin(direction_angle) * speed * delta
		
		if position.x > 1280:
			queue_free()
			
	else:
		position.x -= cos(direction_angle) * speed * delta
		position.y -= sin(direction_angle) * speed * delta
		
		#IF OFF-LIMITS, DELETE
		if position.x < -80:
			queue_free()
			
func _on_body_entered(body: CharacterBody2D) -> void:
	hit.emit(body.plr, damage)
	queue_free()
