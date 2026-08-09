extends Node2D

@export var AVOCADO : PackedScene
@export var SHADOW : PackedScene

func perform_avocado(plr, x_coord, y_coord):
	var avocado_seed = AVOCADO.instantiate()
	var shadow_avocado = SHADOW.instantiate()
	avocado_seed.position = Vector2(clamp(x_coord + 640, 768, 1024), y_coord - 623) if plr == 1 else Vector2(clamp(x_coord - 640, 128, 384), y_coord - 623)# -47
	shadow_avocado.position = Vector2(clamp(x_coord + 640, 768, 1024), clamp(y_coord, 121.5, 576)) if plr == 1 else Vector2(clamp(x_coord - 640, 128, 384), clamp(y_coord, 121.5, 576))
	get_node("/root/main_menu/farmer_frenzy/visual_effects").add_child(avocado_seed)
	get_node("/root/main_menu/farmer_frenzy/animation_effects").add_child(shadow_avocado)
	avocado_seed.desired_position = Vector2(clamp(x_coord + 640, 768, 1024), clamp(y_coord, 121.5, 576)) if plr == 1 else Vector2(clamp(x_coord - 640, 128, 484), clamp(y_coord, 121.5, 576))
	avocado_seed.hit_ground.connect(guacamole_explosion)
	
func guacamole_explosion():
	pass
