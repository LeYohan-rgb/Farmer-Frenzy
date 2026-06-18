extends Node2D

@onready var mango_spr = $fruit_btns/mango
@onready var papaya_spr = $fruit_btns/papaya
@onready var pineapple_spr = $fruit_btns/pineapple
@onready var watermelon_spr = $fruit_btns/watermelon
@onready var guava_spr = $fruit_btns/guava
@onready var avocado_spr = $fruit_btns/avocado
@onready var cocoa_spr = $fruit_btns/cocoa
@onready var coconut_spr = $fruit_btns/coconut

@onready var fruit_lbl = $fruit_label
@onready var fruit_img = $fruit_profile_photo

@onready var cooldown_lbl = $clock_lbl
@onready var bean_lbl = $bean_lbl
@onready var money_cost_lbl = $money_lbl
@onready var desc_lbl = $description
@onready var buy_btn = $buy_btn
@onready var bought_btn = $bought_btn

@onready var plr_currency = $my_currency_lbl
@onready var warning_label = $warning_buying

var selected_fruit : String = ""

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
	show_a_fruit("Mango")


func _on_pineapple_btn_pressed() -> void:
	show_a_fruit("Pineapple")


func _on_guava_btn_pressed() -> void:
	show_a_fruit("Guava")


func _on_cocoa_btn_pressed() -> void:
	show_a_fruit("Cocoa")


func _on_papaya_btn_pressed() -> void:
	show_a_fruit("Papaya")


func _on_watermelon_btn_pressed() -> void:
	show_a_fruit("Watermelon")


func _on_avocado_btn_pressed() -> void:
	show_a_fruit("Avocado")


func _on_coconut_btn_pressed() -> void:
	show_a_fruit("Coconut")
	
func show_a_fruit(fruit : String) -> void:
	selected_fruit = fruit
	fruit_lbl.text = fruit.to_upper()
	fruit_img.texture = load("res://Graphics/" + fruit + ".png")
	
	cooldown_lbl.text = str(Global.cooldown[fruit])
	bean_lbl.text = str(Global.fruit_bean_costs[fruit])
	money_cost_lbl.text = str(Global.fruit_prices[fruit])
	desc_lbl.text = str(Global.long_description[fruit])
	
	if Global.bought_fruits[fruit]:
		buy_btn.hide()
		bought_btn.show()
	else:
		bought_btn.hide()
		buy_btn.show()
		
	


func _on_go_back_btn_pressed() -> void:
	warning_label.modulate.a = 0
	show_a_fruit("Mango")
	self.hide()


func _on_buy_btn_pressed() -> void:
	if Global.plr_currency < Global.fruit_prices[selected_fruit]:
		denied_purchase()

func denied_purchase():
	var tween = create_tween()
	# Fade in
	tween.tween_property(warning_label, "modulate:a", 1.0, 0.5)
	tween.tween_interval(1.5)
	tween.tween_property(warning_label, "modulate:a", 0.0, 0.5)
