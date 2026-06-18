extends Node2D

signal fruit_pressed(fruit : String)

@onready var mango_spr = $mango
@onready var papaya_spr = $papaya
@onready var pineapple_spr = $pineapple
@onready var guava_spr = $guava
@onready var avocado_spr = $avocado
@onready var cocoa_spr = $cocoa
@onready var coconut_spr = $coconut
@onready var watermelon_spr = $watermelon

func _process(delta: float) -> void:
	mango_spr.modulate.a = 1.0 if Global.bought_fruits["Mango"] else 0.4
	papaya_spr.modulate.a = 1.0 if Global.bought_fruits["Papaya"] else 0.4
	pineapple_spr.modulate.a = 1.0 if Global.bought_fruits["Pineapple"] else 0.4
	watermelon_spr.modulate.a = 1.0 if Global.bought_fruits["Watermelon"] else 0.4
	guava_spr.modulate.a = 1.0 if Global.bought_fruits["Guava"] else 0.4
	avocado_spr.modulate.a = 1.0 if Global.bought_fruits["Avocado"] else 0.4
	cocoa_spr.modulate.a = 1.0 if Global.bought_fruits["Cocoa"] else 0.4
	coconut_spr.modulate.a = 1.0 if Global.bought_fruits["Coconut"] else 0.4

func _on_mango_btn_pressed() -> void:
	emit_signal("fruit_pressed", "Mango")


func _on_pineapple_btn_pressed() -> void:
	if !Global.bought_fruits["Pineapple"]:
		return
		
	emit_signal("fruit_pressed", "Pineapple")


func _on_guava_btn_pressed() -> void:
	if !Global.bought_fruits["Guava"]:
		return
	emit_signal("fruit_pressed", "Guava")

func _on_cocoa_btn_pressed() -> void:
	if !Global.bought_fruits["Cocoa"]:
		return
	emit_signal("fruit_pressed", "Cocoa")


func _on_papaya_btn_pressed() -> void:
	emit_signal("fruit_pressed", "Papaya")


func _on_watermelon_btn_pressed() -> void:

	emit_signal("fruit_pressed", "Watermelon")


func _on_avocado_btn_pressed() -> void:
	if !Global.bought_fruits["Avocado"]:
		return
	emit_signal("fruit_pressed", "Avocado")


func _on_coconut_btn_pressed() -> void:
	if !Global.bought_fruits["Coconut"]:
		return
	emit_signal("fruit_pressed", "Coconut")
