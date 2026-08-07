extends Node2D

@export var PINEAPPLE : PackedScene

func perform_pineapple(plr, x_coord, y_coord):
	if Global.pineapple_is_on[plr - 1]:
		return
	
	#PINEAPPLE OUT OF BOUNDS
	if (y_coord + 20) < 200 or (y_coord + 20) > 520:
		return
		
	var pineapple_tile = PINEAPPLE.instantiate()
	pineapple_tile.plr = plr
	pineapple_tile.position.x = 640 if plr == 1 else 0
	pineapple_tile.position.y = return_pineapple_pos(y_coord + 20)[0]
	pineapple_tile.row_type = return_pineapple_pos(y_coord + 20)[1]
	get_node("/root/main_menu/farmer_frenzy/visual_effects").add_child(pineapple_tile)

func return_pineapple_pos(y_coord : float) -> Array:
	if y_coord >= 200 and y_coord < 264:
		return [200, 3]
	if y_coord >= 264 and y_coord < 328:
		return [264, 2]
	if y_coord >= 328 and y_coord < 392:
		return [328, 1]
	if y_coord >= 392 and y_coord < 456:
		return [392, 2]
	if y_coord >= 456 and y_coord < 520:
		return [456, 3]
	return [0, 0]
	
