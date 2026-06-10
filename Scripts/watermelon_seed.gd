extends Area2D

signal hit(player_hit : int, damage_dealt : float)

@export var speed : float
@onready var spr = $Sprite2D
@export var plr : int 
@export var damage : float
var direction : Vector2
var num_of_ricochets : int = 3

func _ready() -> void:
	damage = Global.damage["watermelon_seed"]
	if plr == 2:
		spr.scale.x *= -1
		
func set_angle(my_angle):
	var new_angle = my_angle if plr == 1 else 180.0 - my_angle
	direction = Vector2.RIGHT.rotated(-deg_to_rad(new_angle))
	
func _physics_process(delta: float) -> void:
	
	if num_of_ricochets <= 0:
		queue_free()
		
	if plr != 1 and plr != 2:
		return
		
	position += direction * speed * delta
	if plr == 1:
		#IF OFF-LIMITS, DELETE
		if position.x > 1280:
			queue_free()
	else:
		#IF OFF-LIMITS, DELETE
		if position.x < -80:
			queue_free()
			
func _on_body_entered(body: Node2D) -> void:
		
	if body.name == "border4" or body.name == "border5":
		direction.x *= -1
		if num_of_ricochets == 3:
			num_of_ricochets -= 1 
			speed = 1500
		elif num_of_ricochets == 2:
			num_of_ricochets -= 1 
			speed = 1250
		else:
			num_of_ricochets -= 1 
		
	if body.name == "border" or body.name == "border3":
		direction.y *= -1
		if num_of_ricochets == 3:
			num_of_ricochets -= 1 
			speed = 1500
		elif num_of_ricochets == 2:
			num_of_ricochets -= 1 
			speed = 1250
		else:
			num_of_ricochets -= 1 
