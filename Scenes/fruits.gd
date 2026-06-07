extends Node2D

@export var plr : int
@onready var mango = $mango

func perform(fruit : String):
	if fruit == "Mango":
		mango.shoot_mango(plr)
