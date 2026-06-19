extends Node2D

@export var WATERMELON : PackedScene
@export var SEED : PackedScene
@onready var large_throw_sound = $large_throw
@onready var small_throw_sound = $small_throw
@onready var juicy_splash = $juicy_splash
@onready var small_impact = $small_impact
var track_watermelon : Area2D


func perform_watermelon(plr : int, x_coord : float = 0.0, y_coord : float = 0.0) -> void:
	if Global.watermelon_is_alive[plr - 1]:
		var reference_angle : float
		if plr == 1:
			reference_angle = 20.0 - (11.0 * x_coord / 512.0)
		else:
			reference_angle = 20.0 - (11.0 * (x_coord - 640) / 512.0)
		shoot_seeds(plr, track_watermelon.position.x, track_watermelon.position.y, reference_angle / 3 )
		shoot_seeds(plr, track_watermelon.position.x, track_watermelon.position.y, reference_angle * 2 / 3)
		shoot_seeds(plr, track_watermelon.position.x, track_watermelon.position.y, reference_angle)
		shoot_seeds(plr, track_watermelon.position.x, track_watermelon.position.y)
		shoot_seeds(plr, track_watermelon.position.x, track_watermelon.position.y, reference_angle / -3)
		shoot_seeds(plr, track_watermelon.position.x, track_watermelon.position.y, reference_angle * 2 / -3)
		shoot_seeds(plr, track_watermelon.position.x, track_watermelon.position.y, reference_angle * -1)
		small_throw_sound.play()
	else:
		shoot_watermelon(plr, x_coord, y_coord)

	
	
func shoot_watermelon(player : int, position_x, position_y) -> void:
	var watermelon_item = WATERMELON.instantiate()
	track_watermelon = watermelon_item
	watermelon_item.speed = Global.speed["watermelon"]
	watermelon_item.plr = player
	watermelon_item.position.y = position_y
	
	var offset = 60 if player == 1 else -60
	watermelon_item.position.x = position_x + offset
	get_node("/root/main_menu/farmer_frenzy/visual_effects").add_child(watermelon_item)
	large_throw_sound.play()
	watermelon_item.hit.connect(damage_watermelon)
	watermelon_item.dead.connect(watermelon_died)
	await get_tree().physics_frame
	Global.watermelon_is_alive[player - 1] = true

func damage(player_hitted : int, damage_dealt : float) -> void:
	small_impact.play()
	if player_hitted == 1:
		Global.player_1_health -= damage_dealt * Global.player_1_dmg_boost
	else:
		Global.player_2_health -= damage_dealt * Global.player_2_dmg_boost
		
func damage_watermelon(player_hitted : int, damage_dealt : float) -> void:
	juicy_splash.play()
	if player_hitted == 1:
		Global.player_1_health -= damage_dealt * Global.player_1_dmg_boost
	else:
		Global.player_2_health -= damage_dealt * Global.player_2_dmg_boost
		
func watermelon_died(my_plr : int) -> void:
	Global.watermelon_is_alive[my_plr - 1] = false
	
func shoot_seeds(player : int, position_x, position_y, angle : float = 0.0) -> void:
	var seed_item = SEED.instantiate()
	seed_item.speed = Global.speed["watermelon_seeds"]
	seed_item.plr = player
	seed_item.position.y = position_y
	seed_item.set_angle(angle)
	
	var offset = 60 if player == 1 else -60
	seed_item.position.x = position_x + offset
	get_node("/root/main_menu/farmer_frenzy/visual_effects").add_child(seed_item)
	seed_item.hit.connect(damage)
