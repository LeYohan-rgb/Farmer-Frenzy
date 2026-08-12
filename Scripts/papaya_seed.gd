extends Area2D


signal hit(player_hit : int, damage_dealt : float)

@export var speed : int
@onready var spr = $Sprite2D
@export var plr : int 
@export var damage : float

func _ready() -> void:
	if plr == 2:
		spr.scale.x *= -1
		
func _physics_process(delta: float) -> void:
	
	if plr != 1 and plr != 2:
		return
	
	if plr == 1:
		position.x += speed * delta
		
		if position.x > 1280:
			queue_free()
			
	else:
		position.x -= speed * delta
		
		#IF OFF-LIMITS, DELETE
		if position.x < -80:
			queue_free()
			
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
