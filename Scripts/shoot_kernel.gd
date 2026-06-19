extends Node2D

signal wants_to_shoot(plr : int)
@export var plr : int
@export var KERNEL : PackedScene
@onready var shoot_sound = $shoot_kernel_sound
@onready var impact_sound = $impact_sound
var recharge_bounce : bool = false

func _physics_process(delta: float) -> void:
	if !Global.is_in_farmer_fight:
		return
	
	if Global.kernel_amount[plr - 1] <= 0:
		if !recharge_bounce:
			get_tree().create_timer(Global.recharge_time).timeout.connect(recharge_kernel)
			recharge_bounce = true
		return
		
	if Input.is_action_just_pressed("kernel_1"):
		wants_to_shoot.emit(1)

	if Input.is_action_just_pressed("kernel_2"):
		wants_to_shoot.emit(2)
		
func shoot(plr : int, position_x, position_y):
	Global.kernel_amount[plr - 1] -= 1
	var kernel = KERNEL.instantiate()
	kernel.speed = Global.speed["kernel"]
	kernel.plr = plr
	kernel.position.y = position_y + 5
	
	var offset = 45 if plr == 1 else -45
	kernel.position.x = position_x + offset
	get_node("/root/main_menu/farmer_frenzy/visual_effects").add_child(kernel)
	shoot_sound.play()
	kernel.hit.connect(damage)
	
func damage(player_hitted : int):
	impact_sound.play()
	if player_hitted == 1:
		Global.player_1_health -= Global.damage["kernel"] * Global.player_1_dmg_boost
	else:
		Global.player_2_health -= Global.damage["kernel"] * Global.player_2_dmg_boost
		
func recharge_kernel():
	Global.kernel_amount[plr - 1] = 10
	recharge_bounce = false
