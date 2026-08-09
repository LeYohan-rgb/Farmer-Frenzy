extends Node2D

@export var AVOCADO : PackedScene
@export var SHADOW : PackedScene

func perform_avocado(plr, x_coord, y_coord):
	var avocado_seed = AVOCADO.instantiate()
	var shadow_avocado = SHADOW.instantiate()
	avocado_seed.position = Vector2(clamp(x_coord + 640, 768, 1024), y_coord - 623) # -47
	shadow_avocado.position = Vector2(clamp(x_coord + 640, 768, 1024), clamp(y_coord, 121.5, 576)) 
	get_node("/root/main_menu/farmer_frenzy/visual_effects").add_child(avocado_seed)
	get_node("/root/main_menu/farmer_frenzy/animation_effects").add_child(shadow_avocado)
	print("AVOOO")
	avocado_seed.desired_position = Vector2(clamp(x_coord + 640, 768, 1024), clamp(y_coord, 121.5, 576))
	avocado_seed.hit_ground.connect(guacamole_explosion)
	
func guacamole_explosion():
	pass

#func required_acceleration(time: float) -> float:
	#var distance = 623.0
	#return 2.0 * distance / (time * time)

#velocity_y += gravity * delta
#position.y += velocity_y * delta

	#var guava_item = GUAVA_SEED.instantiate()
	#guava_item.plr = plr
	#guava_item.position = random_point_in_circle(Vector2(x_coord, y_coord), 256, plr)
	#get_node("/root/main_menu/farmer_frenzy/visual_effects").add_child(guava_item)
	#guava_item.heal.connect(guava_effect)
