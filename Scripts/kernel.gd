extends Area2D

signal hit(player_hit : int)

@export var speed : int
@onready var spr = $Sprite2D
@export var plr : int
@export var damage : float

func _ready() -> void:
	damage = Global.damage["kernel"]
	
func _physics_process(delta: float) -> void:
	if plr != 1 and plr != 2:
		return
		
	if plr == 1:
		position.x += speed * delta
		
		#IF OFF-LIMITS, DELETE
		if position.x > 1280:
			queue_free()
	else:
		spr.rotation_degrees = 270
		position.x -= speed * delta
		
		#IF OFF-LIMITS, DELETE
		if position.x < -80:
			queue_free()
			
func _on_body_entered(body: CharacterBody2D) -> void:
	hit.emit(body.plr)
	queue_free()
	
