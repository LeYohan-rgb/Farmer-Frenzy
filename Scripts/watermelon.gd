extends Area2D

signal hit(player_hit : int, damage_dealt : float)
signal dead

@export var speed : int
@onready var spr = $AnimatedSprite2D
@export var plr : int 
@export var damage : float

func _ready() -> void:
	damage = Global.damage["watermelon"]
	if plr == 2:
		spr.scale.x *= -1
		
func _physics_process(delta: float) -> void:
	
	if plr != 1 and plr != 2:
		return
	
	if plr == 1:
		position.x += speed * delta
		
		if position.x > 1280:
			dead.emit()
			queue_free()
			
	else:
		position.x -= speed * delta
		
		#IF OFF-LIMITS, DELETE
		if position.x < -80:
			dead.emit()
			queue_free()
			
func _on_body_entered(body: CharacterBody2D) -> void:
	hit.emit(body.plr, damage)
	dead.emit()
	queue_free()
