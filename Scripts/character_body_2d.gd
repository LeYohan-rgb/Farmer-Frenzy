extends CharacterBody2D

@export var plr : int
@onready var anim = $animation
#SCRIPTS
@onready var shoot_kernel = $shoot_kernel
@onready var shield = $summon_shield
@onready var fruits = $fruits
@onready var mango = $fruits/mango
@onready var watermelon = $fruits/watermelon

var speed = Global.farmer_fight_velocity
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	#SETTING UP PLR TO EACH SCRIPT
	shield.plr = plr
	shoot_kernel.plr = plr
	fruits.plr = plr
	
	fruits.connect("shoot_melon_with_coords", give_out_coords)
	mango.connect("shoot_with_coords", give_out_coords)
	shoot_kernel.connect("wants_to_shoot", shoot_active)
	shield.connect("wants_to_shield", shield_active)

func _physics_process(delta: float) -> void:
	if !Global.is_in_farmer_fight:
		return
		
	if Global.is_shielding[plr - 1]:
		velocity = Vector2.ZERO
		move_and_slide()
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
		
func shield_active(plr_input : int):
	if plr_input == plr:
		shield.protect(plr, position.x, position.y)
	else:
		pass

func perform_ability(fruit_name : String):
	if fruit_name == "Mango":
		fruits.perform(fruit_name)
	if fruit_name == "Watermelon":
		fruits.perform(fruit_name, position.x, position.y)
		
func give_out_coords(fruit : String):
	if fruit == "mango":
		mango.shoot_mango_with_coords(position.x, position.y, plr)
	if fruit == "watermelon":
		watermelon.perform_watermelon(plr, position.x, position.y)
