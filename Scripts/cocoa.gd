extends Node2D

@export var CHOCOLATE_FARMER : PackedScene

func perform_cocoa(plr : int, x_coord : float, y_coord : float) -> void:
	var farmer_1 = CHOCOLATE_FARMER.instantiate()
	var farmer_2 = CHOCOLATE_FARMER.instantiate()
	var farmer_3 = CHOCOLATE_FARMER.instantiate()
	
	farmer_1.position = Vector2(100, 232)
	farmer_2.position = Vector2(100, 360)
	farmer_3.position = Vector2(100, 488)


#THE FARTHER THEY ARE,, THE MORE HEALTH & LIVE LONGER
#THE CLOSER, THE LESS HEALTH

#THERE ARE FOUR REGIONS: 0-128, 129-256, 257-384, 384-512


	#var avocado_seed = AVOCADO.instantiate()
	#var shadow_avocado = SHADOW.instantiate()
	#avocado_seed.position = Vector2(clamp(x_coord + 640, 768, 1024), y_coord - 623) if plr == 1 else Vector2(clamp(x_coord - 640, 128, 384), y_coord - 623)# -47
	#shadow_avocado.position = Vector2(clamp(x_coord + 640, 768, 1024), clamp(y_coord, 121.5, 576)) if plr == 1 else Vector2(clamp(x_coord - 640, 128, 384), clamp(y_coord, 121.5, 576))
	#get_node("/root/main_menu/farmer_frenzy/visual_effects").add_child(avocado_seed)
	#get_node("/root/main_menu/farmer_frenzy/animation_effects").add_child(shadow_avocado)
	#avocado_seed.desired_position = Vector2(clamp(x_coord + 640, 768, 1024), clamp(y_coord, 121.5, 576)) if plr == 1 else Vector2(clamp(x_coord - 640, 128, 484), clamp(y_coord, 121.5, 576))
	#avocado_seed.hit_ground.connect(guacamole_explosion)
