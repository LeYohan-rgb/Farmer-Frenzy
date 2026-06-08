extends Node2D

func get_bar(num, plr) -> ProgressBar:
	return get_node("cooldown_bar_%d_%d" % [num, plr])
	
func get_timer(num, plr) -> Timer:
	return get_node("timer_%d_%d" % [num, plr])
	
func _process(delta: float) -> void:
	if get_timer(1, 1).is_stopped():
		get_bar(1,1).value = 0
		Global.is_in_cooldown[1][1] = false
	else:
		get_bar(1,1).value = get_timer(1,1).time_left / get_timer(1,1).wait_time * 100
	if get_timer(2, 1).is_stopped():
		get_bar(2,1).value = 0
		Global.is_in_cooldown[1][2] = false
	else:
		get_bar(2,1).value = get_timer(2,1).time_left / get_timer(2,1).wait_time * 100
	if get_timer(3, 1).is_stopped():
		get_bar(3,1).value = 0
		Global.is_in_cooldown[1][3] = false
	else:
		get_bar(3,1).value = get_timer(3,1).time_left / get_timer(3,1).wait_time * 100
	if get_timer(1, 2).is_stopped():
		get_bar(1,2).value = 0
		Global.is_in_cooldown[2][1] = false
	else:
		get_bar(1,2).value = get_timer(1,2).time_left / get_timer(1,2).wait_time * 100
	if get_timer(2, 2).is_stopped():
		get_bar(2,2).value = 0
		Global.is_in_cooldown[2][2] = false
	else:
		get_bar(2,2).value = get_timer(2,2).time_left / get_timer(2,2).wait_time * 100
	if get_timer(3, 2).is_stopped():
		get_bar(3,2).value = 0
		Global.is_in_cooldown[2][3] = false
	else:
		get_bar(3,2).value = get_timer(3,2).time_left / get_timer(3,2).wait_time * 100

		
