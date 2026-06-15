extends Node2D

signal shoot_papayas(number : float)
@export var plr : int
@onready var progress_bar = $TextureProgressBar
@onready var my_timer = $Timer
@onready var deplete_timer = $deplete_timer

func _ready():
	deplete_timer.timeout.connect(_on_deplete_finished)

func _on_deplete_finished():
	if !Global.is_in_farmer_fight:
		Global.papaya_charging_state[plr - 1] = 0
	else:
		Global.papaya_charging_state[plr - 1] = 1
		
	if Global.papaya_seeds_count[plr - 1] <= 0:
		Global.papaya_charging_state[plr - 1] = 0
	self.hide()
	
func start_fulling_bar():
	my_timer.start()
	
func start_depleting_bar():
	var filled_amount = progress_bar.max_value - my_timer.time_left
	var num_of_papayas : int = clamp(int(round(filled_amount / 0.15)), 0,  Global.papaya_seeds_count[plr - 1])
	shoot_papayas.emit(num_of_papayas)
	my_timer.stop()
	deplete_timer.start(filled_amount)
	
func _process(delta: float) -> void:
	if !Global.is_in_farmer_fight:
		return
		
	if Global.papaya_charging_state[plr - 1] == 2:
		progress_bar.value = progress_bar.max_value - my_timer.time_left
			
	if Global.papaya_charging_state[plr -1] == 3:
		prints(progress_bar.value, deplete_timer.time_left)
		progress_bar.value = deplete_timer.time_left
		
	
