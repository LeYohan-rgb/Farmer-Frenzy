extends CharacterBody2D

@export var plr : int
@onready var anim = $animation

#SCRIPTS
@onready var shoot_kernel = $shoot_kernel

var speed = Global.farmer_fight_velocity
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	shoot_kernel.connect("wants_to_shoot", shoot_active)

func _physics_process(delta: float) -> void:
	if !Global.is_in_farmer_fight:
		return
		
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("right_" + str(plr)) - Input.get_action_strength("left_" + str(plr))
	input_vector.y = Input.get_action_strength("down_" + str(plr)) - Input.get_action_strength("up_" + str(plr))
	
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
		
	velocity = input_vector * speed
	move_and_slide()

func set_up_before_battle():
	if plr == 1:
		anim.play("emiliano")
	else:
		anim.play("jeronimo")
		
func shoot_active(plr_input : int):
	if plr_input == plr:
		shoot_kernel.shoot(plr, position.x, position.y)
	else:
		pass
