extends CharacterBody2D

@export var plr : int
@onready var anim = $animation
#SCRIPTS
@onready var shoot_kernel = $shoot_kernel
@onready var shield = $summon_shield
@onready var fruits = $fruits
@onready var mango = $fruits/mango
@onready var watermelon = $fruits/watermelon
@onready var papaya = $fruits/papaya
@onready var farmer_UI = $farmer_UI

var speed = Global.farmer_fight_velocity
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	#SETTING UP PLR TO EACH SCRIPT
	shield.plr = plr
	shoot_kernel.plr = plr
	fruits.plr = plr
	farmer_UI.plr = plr
	
	
	papaya.connect("shoot_papaya_with_coords", give_out_coords)
	farmer_UI.connect("shoot_papayas", shoot_papayas)
	fruits.connect("papaya_timer_started", papaya_timer_start)
	fruits.connect("shoot_melon_with_coords", give_out_coords)
	mango.connect("shoot_with_coords", give_out_coords)
	shoot_kernel.connect("wants_to_shoot", shoot_active)
	shield.connect("wants_to_shield", shield_active)

func _physics_process(delta: float) -> void:
	#print(position.y)
	
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
	if Global.is_shielding[plr_input - 1]:
		return
		
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
	if fruit_name == "Papaya":
		fruits.perform(fruit_name, position.x, position.y)
	if fruit_name == "Pineapple":
		fruits.perform(fruit_name, position.x, position.y)
		
func give_out_coords(fruit : String):
	if fruit == "mango":
		mango.shoot_mango_with_coords(position.x, position.y, plr)
	if fruit == "watermelon":
		watermelon.perform_watermelon(plr, position.x, position.y)
	if fruit == "papaya":
		papaya.shoot_papayas_with_coords(position.x, position.y, plr)
	
		
func papaya_timer_start(on_or_off : int):
	if on_or_off == 0:
		farmer_UI.show()
		farmer_UI.start_fulling_bar()
	else:
		farmer_UI.start_depleting_bar()

func quit_game():
	farmer_UI.hide()

func shoot_papayas(num_of_papayas : int):
	papaya.perform_shooting_papaya(num_of_papayas, plr)


func _on_feet_area_entered(area: Area2D) -> void:
	if area.name == "pineapple":
		var damage_dealt = Global.damage["pineapple"][area.row_type - 1]
		Global.pineapple_effect[plr - 1] = true
		speed = 100
		#WHILE LOOP
		while Global.pineapple_effect[plr - 1]:
			if plr == 1:
				Global.player_1_health -= damage_dealt * Global.player_1_dmg_boost
			else:
				Global.player_2_health -= damage_dealt * Global.player_2_dmg_boost
			await Global.wait(1)


func _on_feet_area_exited(area: Area2D) -> void:
	if area.name == "pineapple":
		Global.pineapple_effect[plr - 1] = false
		print("FALSE")
		speed = 275
