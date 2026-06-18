extends Area2D

signal hit(player_hit : int, damage_dealt : float)
signal dead(player : int)

@export var speed : int
@onready var spr = $AnimatedSprite2D
@export var plr : int 
@export var damage : float
@export var SPLASH : PackedScene

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
			dead.emit(plr)
			queue_free()
			
	else:
		position.x -= speed * delta
		
		#IF OFF-LIMITS, DELETE
		if position.x < -80:
			dead.emit(plr)
			queue_free()
			
func _on_body_entered(body: CharacterBody2D) -> void:
	hit.emit(body.plr, damage)
	dead.emit(plr)
	queue_free()

	#SPLASH
	var x_offset = randf_range(-10,10)
	var y_offset = randf_range(-10,10)
	var my_splash = SPLASH.instantiate()
	my_splash.position.x = position.x + x_offset
	my_splash.position.y = position.y + y_offset
	get_node("/root/main_menu/farmer_frenzy/visual_effects").add_child(my_splash)
	my_splash.splashed()
