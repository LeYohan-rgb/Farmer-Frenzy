extends Node2D

@export var plr : int
@onready var mango = $mango

func perform(fruit : String, position_x, position_y):
	if fruit == "Mango":
		mango.shoot_mango(plr, position_x, position_y)
