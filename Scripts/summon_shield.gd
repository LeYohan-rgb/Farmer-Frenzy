extends Node2D

signal wants_to_shield(plr_input : int)
@export var plr : int
@export var SHIELD : PackedScene
var instantiated_shield : Area2D

func _physics_process(delta: float) -> void:
	if !Global.is_in_farmer_fight:
		return
		
	if Global.is_shielding[plr - 1] and Global.shield[plr - 1] <= 0:
		remove_shield()
		
	if Input.is_action_just_pressed("shield_"+str(plr)):
		if Global.is_shielding[plr - 1] or Global.shield[plr - 1] <= 0:
			return
		wants_to_shield.emit(plr)
	
	if Input.is_action_pressed("shield_"+str(plr)):
		if Global.shield[plr - 1] <= 0:
			return
			
		Global.is_shielding[plr - 1] = true
		
	if Input.is_action_just_released("shield_"+str(plr)):
		if is_instance_valid(instantiated_shield):
			remove_shield()
		
		
func remove_shield():
	if !is_instance_valid(instantiated_shield):
		return
		
	instantiated_shield.queue_free()
	instantiated_shield = null
	Global.is_shielding[plr - 1] = false
	
func protect(plr : int, position_x, position_y):
	var shield = SHIELD.instantiate()
	instantiated_shield = shield
	shield.plr = plr
	shield.position.y = position_y
	
	var offset = 35 if plr == 1 else -35
	shield.position.x = position_x + offset
	get_node("/root/main_menu/farmer_frenzy/visual_effects").add_child(shield)
	shield.hit.connect(shield_damaged)
	
func shield_damaged(dmg : int):
	Global.shield[plr - 1] -= dmg
