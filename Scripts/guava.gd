extends Node2D

@export var GUAVA_SEED : PackedScene

func perform_guava(plr, x_coord, y_coord):
	for i in range(20):
		generate_guava_seed(plr, x_coord, y_coord)
	
func generate_guava_seed(plr, x_coord, y_coord):
	var guava_item = GUAVA_SEED.instantiate()
	guava_item.plr = plr
	guava_item.position = random_point_in_circle(Vector2(x_coord, y_coord), 192, plr)
	get_node("/root/main_menu/farmer_frenzy/visual_effects").add_child(guava_item)
	

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
