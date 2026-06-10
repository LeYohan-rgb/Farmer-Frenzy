extends Node2D

@export var plr : int
@onready var mango = $mango
@onready var watermelon = $watermelon
signal shoot_melon_with_coords(fruit : String)

func _process(delta: float) -> void:
	if !Global.is_in_farmer_fight:
		return
		
	if Global.is_fruit_in_party("Watermelon") and Global.watermelon_is_alive:
		if Input.is_action_just_pressed(Global.num_to_ordinal(Global.fruit_to_slot("Watermelon", plr))+"_"+str(plr)):
			shoot_melon_with_coords.emit("watermelon")
			Global.watermelon_is_alive = false
			
func perform(fruit : String, x_coord : float = 0.0, y_coord : float = 0.0):
	if fruit == "Mango":
		mango.perform_mango(plr)
	if fruit == "Watermelon":
		watermelon.perform_watermelon(plr, x_coord, y_coord)
