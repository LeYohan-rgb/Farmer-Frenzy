extends Node2D

signal game_paused(on_or_off : int)
signal leave_game

@onready var main_panel = $main_panel
@onready var pause_btn_lbl = $"pause_ btn"
@onready var timer_lbl = $timer_lbl
@onready var timer = $Timer
var is_pausing = false
var remaining_time := 0.0

func _on_pause__btn_pressed() -> void:
	if !Global.is_in_farmer_fight:
		return
		
	if !is_pausing:
		main_panel.show()
		game_paused.emit(0)
		is_pausing = true
		get_tree().paused = true
		pause_btn_lbl.text = "RESUME"
		
	else:
		main_panel.hide()
		game_paused.emit(1)
		is_pausing = false
		get_tree().paused = false
		pause_btn_lbl.text = "PAUSE"


func _on_return_to_main_pressed() -> void:
		
	is_pausing = false
	pause_btn_lbl.text = "PAUSE"
	main_panel.hide()
	leave_game.emit()


func _on_timer_timeout() -> void:
	Global.game_time += 1
	var minutes = Global.game_time / 60
	var seconds = Global.game_time % 60
	timer_lbl.text = '%02d:%02d' % [minutes, seconds]
	
