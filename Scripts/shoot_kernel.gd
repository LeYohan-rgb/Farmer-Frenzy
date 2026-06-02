extends Node2D

signal wants_to_shoot(plr : int)
@export var KERNEL : PackedScene

func _physics_process(delta: float) -> void:
	if !Global.is_in_farmer_fight:
		return
		
	if Input.is_action_just_pressed("kernel_1"):
		wants_to_shoot.emit(1)

	if Input.is_action_just_pressed("kernel_2"):
		wants_to_shoot.emit(2)
		
func shoot(plr : int, position_x, position_y):
	var kernel = KERNEL.instantiate()
	kernel.speed = Global.kernel_speed
	kernel.plr = plr
	kernel.position.y = position_y + 5
	
	var offset = 45 if plr == 1 else -45
	kernel.position.x = position_x + offset
	get_tree().current_scene.add_child(kernel)
	kernel.hit.connect(damage)
	
func damage(player_hitted : int):
	if player_hitted == 1:
		pass
	else:
		pass
