extends Area2D


signal hit(player_hit : int, damage_dealt : float)

@export var speed : int
@onready var spr = $Sprite2D
@export var plr : int 
@export var damage : float
@export var SPLASH : PackedScene

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
	if body is CharacterBody2D:
		hit.emit(body.plr, damage)
		queue_free()
		
	if body is StaticBody2D and body.is_in_group("hitable"):
		if plr == 1:
			body.receive_damage(damage * Global.player_1_dmg_boost, plr)
		else:
			body.receive_damage(damage * Global.player_2_dmg_boost, plr)
		queue_free()

	#SPLASH
	var x_offset = randf_range(-10,10)
	var y_offset = randf_range(-10,10)
	var my_splash = SPLASH.instantiate()
	my_splash.position.x = position.x + x_offset
	my_splash.position.y = position.y + y_offset
	get_node("/root/main_menu/farmer_frenzy/visual_effects").add_child(my_splash)
	my_splash.splashed()
