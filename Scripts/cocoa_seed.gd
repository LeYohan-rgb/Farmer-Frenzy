extends Area2D

@export var plr : int
@export var speed : float = Global.speed["cocoa_seed"]#1800
@onready var spr = $Sprite2D
@onready var my_col = $CollisionPolygon2D
@export var damage : float = Global.damage["cocoa_seed"]
@onready var hit_sfx = $hit

var position_shooting : Vector2
var is_reflected := false

func _ready():
	if plr == 1:
		position_shooting = Vector2.RIGHT
	elif plr == 2:
		position_shooting = Vector2.LEFT
		spr.scale.x *= -1
		
		
func _physics_process(delta: float) -> void:
	if plr != 1 and plr != 2:
		return
		
	position += position_shooting * speed * delta

	# Only rotate after being reflected
	if is_reflected:
		rotation = position_shooting.angle()

	if position.x > 1280 or position.x < -80:
		queue_free()

func rotate_seed(pos : Vector2):
	position_shooting = (pos - position).normalized()
	is_reflected = true
	rotation = position_shooting.angle()


func _on_body_entered(body) -> void:
	if is_instance_valid(body) and body is CharacterBody2D and body.plr != plr:
		body.receive_damage(damage, plr)
		_hit()
		
	if is_instance_valid(body) and body is StaticBody2D and body.is_in_group("hitable"):
		body.receive_damage(damage, plr)
		_hit()
		
func _hit():
	spr.hide()
	set_physics_process(false)
	my_col.set_deferred("disabled", true)

	hit_sfx.play()
	hit_sfx.finished.connect(queue_free)
