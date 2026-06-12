extends Node2D

@export var plr : int
@onready var progress_bar = $TextureProgressBar
@onready var my_timer = $Timer
var started_timer : bool = false

func start_fulling_bar():
	if !started_timer:
		my_timer.start()
		started_timer = true
	
func start_depleting_bar():
	var time_remaining = my_timer.time_left
	my_timer.stop()
	my_timer.start(time_remaining)
	
func _process(delta: float) -> void:
	if !Global.is_in_farmer_fight:
		return
		
	if Global.papaya_charging_state[plr - 1] == 2:
			progress_bar.value = progress_bar.max_value - my_timer.time_left
			
	if Global.papaya_charging_state[plr -1] == 3:
		progress_bar.value = my_timer.time_left
		
	
