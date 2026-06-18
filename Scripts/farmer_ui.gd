extends Node2D

signal shoot_papayas(number : float)
@export var plr : int
@onready var progress_bar = $TextureProgressBar
@onready var my_timer = $Timer
@onready var deplete_timer = $deplete_timer


	
func start_fulling_bar():
	my_timer.start()
	
func start_depleting_bar():
	var filled_amount = progress_bar.max_value - my_timer.time_left
	var num_of_papayas : int = clamp(int(round(filled_amount / 0.075)), 0,  Global.papaya_seeds_count[plr - 1])
	var true_deplete_timer : float = round(filled_amount / 0.075) * 0.075


	shoot_papayas.emit(num_of_papayas)
	my_timer.stop()
	await get_tree().process_frame
	await get_tree().process_frame
	deplete_timer.start(true_deplete_timer)
	
func _process(delta: float) -> void:
	if !Global.is_in_farmer_fight:
		return
		
	if Global.papaya_charging_state[plr - 1] == 2:
		progress_bar.value = progress_bar.max_value - my_timer.time_left
			
	if Global.papaya_charging_state[plr -1] == 3:
		progress_bar.value = deplete_timer.time_left
		
func _on_papaya_shooting_mango_terminated() -> void:
	if !Global.is_in_farmer_fight:
		Global.papaya_charging_state[plr - 1] = 0
	else:
		Global.papaya_charging_state[plr - 1] = 1
		
	if Global.papaya_seeds_count[plr - 1] <= 0:
		Global.papaya_charging_state[plr - 1] = 0
	self.hide()
	Global.can_shield[plr - 1] =true
