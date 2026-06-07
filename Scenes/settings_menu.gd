extends Node2D

signal hide_settings

@onready var farmer_name_1 = $farmer_name_1
@onready var farmer_name_2 = $farmer_name_2
@onready var plr_1_score = $plr_1_score
@onready var plr_2_score = $plr_2_score

func _process(delta: float) -> void:
	plr_1_score.text = str(Global.player_1_wins)
	plr_2_score.text = str(Global.player_2_wins)
	
func _on_go_back_btn_pressed() -> void:
	hide_settings.emit()


func _on_farmer_name_1_text_changed(new_text: String) -> void:
	Global.player_name_1 = new_text

func _on_farmer_name_2_text_changed(new_text: String) -> void:
	Global.player_name_2 = new_text
