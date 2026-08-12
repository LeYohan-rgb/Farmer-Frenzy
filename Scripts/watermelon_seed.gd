extends Area2D


signal hit(player_hit : int, damage_dealt : float)


@export var speed : float
@onready var spr = $Sprite2D
@export var plr : int 
@export var damage : float
var direction : Vector2 = Vector2.ZERO
var num_of_ricochets : int = 3
@onready var impact_sound = $impact_sound

var is_reflected := false

func _ready() -> void:
	damage = Global.damage["watermelon_seed"]
	if plr == 2:
		spr.scale.x *= -1
		
	if direction == Vector2.ZERO:
		if plr == 1:
			direction = Vector2.RIGHT
		elif plr == 2:
			direction = Vector2.LEFT
		
func set_angle(my_angle):
	var new_angle = my_angle if plr == 1 else 180.0 - my_angle
	direction = Vector2.RIGHT.rotated(-deg_to_rad(new_angle))
	
func _physics_process(delta: float) -> void:
	
	if num_of_ricochets <= 0:
		queue_free()
		
	if plr != 1 and plr != 2:
		return
		
	position += direction * speed * delta
	
	if is_reflected:
		rotation = direction.angle()
		
		#IF OFF-LIMITS, DELETE
	if position.x > 1280 or position.x < -80:
		queue_free()
		
func rotate_seed(pos : Vector2) -> void:
	direction = (pos - position).normalized()
	is_reflected = true
	rotation = direction.angle()
			
func _on_body_entered(body: Node2D) -> void:
	
	if is_instance_valid(body) and body is CharacterBody2D and body.plr != plr:
		hit.emit(body.plr, damage)
		queue_free()
		
	if is_instance_valid(body) and body is StaticBody2D and body.is_in_group("hitable") and body.plr != plr:
		if plr == 1:
			body.receive_damage(damage * Global.player_1_dmg_boost, plr)
		else:
			body.receive_damage(damage * Global.player_2_dmg_boost, plr)
		queue_free()
		
	if is_instance_valid(body) and  (body.name == "border4" or body.name == "border5"):
		impact_sound.play()
		direction.x *= -1
		if num_of_ricochets == 3:
			num_of_ricochets -= 1 
			speed = 1500
		elif num_of_ricochets == 2:
			num_of_ricochets -= 1 
			speed = 1250
		else:
			num_of_ricochets -= 1 
		
	if is_instance_valid(body) and (body.name == "border" or body.name == "border3"):
		impact_sound.play()
		direction.y *= -1
		if num_of_ricochets == 3:
			num_of_ricochets -= 1 
			speed = 1500
		elif num_of_ricochets == 2:
			num_of_ricochets -= 1 
			speed = 1250
		else:
			num_of_ricochets -= 1 
