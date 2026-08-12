extends Area2D

@export var plr : int
@onready var spr = $Sprite2D
@onready var reflect_sfx = $reflect_audio

func _ready():
	if plr == 2:
		spr.scale.x *= 1

func _on_area_entered(area: Area2D) -> void:
	if !is_instance_valid(area):
		return
		
	if area.is_in_group("projectile") and area.plr != plr:
		var opposing_plr_location
		if plr == 1:
			opposing_plr_location = get_node("/root/main_menu/farmer_frenzy/farmers/farmer2")
		else:
			opposing_plr_location = get_node("/root/main_menu/farmer_frenzy/farmers/farmer")
		area.rotate_seed(opposing_plr_location.global_position)
		
		#SPEED
		area.speed *= 2
		area.plr = plr
		reflect_sfx.play()
