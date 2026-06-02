extends Node2D

signal fruit_pressed(fruit : String)

func _on_mango_btn_pressed() -> void:
	emit_signal("fruit_pressed", "Mango")


func _on_pineapple_btn_pressed() -> void:
	emit_signal("fruit_pressed", "Pineapple")


func _on_guava_btn_pressed() -> void:
	emit_signal("fruit_pressed", "Guava")

func _on_cocoa_btn_pressed() -> void:
	emit_signal("fruit_pressed", "Cocoa")


func _on_papaya_btn_pressed() -> void:
	emit_signal("fruit_pressed", "Papaya")


func _on_watermelon_btn_pressed() -> void:
	emit_signal("fruit_pressed", "Watermelon")


func _on_avocado_btn_pressed() -> void:
	emit_signal("fruit_pressed", "Avocado")


func _on_coconut_btn_pressed() -> void:
	emit_signal("fruit_pressed", "Coconut")
