extends Node2D

@export var GUAVA_SEED : PackedScene
@onready var healing_sfx = $guava_sfx
@onready var timer = $Timer
signal heal
signal speed_boost(on_or_off : bool)

func perform_guava(plr, x_coord, y_coord):
	for i in range(20):
		generate_guava_seed(plr, x_coord, y_coord)
	
func generate_guava_seed(plr, x_coord, y_coord):
	var guava_item = GUAVA_SEED.instantiate()
	guava_item.plr = plr
	guava_item.position = random_point_in_circle(Vector2(x_coord, y_coord), 256, plr)
	get_node("/root/main_menu/farmer_frenzy/visual_effects").add_child(guava_item)
	guava_item.heal.connect(guava_effect)
	
	
func guava_effect(player_healed : int, heal_amount : float):
	if player_healed == 1:
		if Global.player_1_health < Global.maximum_health:
			healing_sfx.play()
			heal.emit()
		Global.player_1_health += heal_amount * Global.player_1_healing_boost
	else:
		if Global.player_2_health < Global.maximum_health:
			healing_sfx.play()
			heal.emit()
		Global.player_2_health += heal_amount * Global.player_2_healing_boost
	speed_effect(player_healed)
	
func speed_effect(plr : int) -> void:
	if Global.guava_effect[plr - 1]:
		timer.start()
		return
	
	Global.guava_effect[plr - 1] = true
	speed_boost.emit(true)
	timer.start()
	await timer.timeout
	speed_boost.emit(false)
	Global.guava_effect[plr - 1] = false
	

func random_point_in_circle(center: Vector2, radius: float, player : int) -> Vector2:
	var angle = randf() * TAU
	var distance = sqrt(randf()) * radius
	
	var offset = Vector2(cos(angle), sin(angle)) * distance
	var final_coords =  center + offset
	
	#OFFSET IS 5 PIXELS
	if player == 1:
		final_coords.x = clamp(final_coords.x, 5.0, 507.0)
	else:
		final_coords.x = clamp(final_coords.x, 653.0, 1147.0)
	final_coords.y = clamp(final_coords.y, 77.0, 643.0)
	
	return final_coords
