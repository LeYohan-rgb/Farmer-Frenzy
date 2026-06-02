extends Node2D

@onready var farmer_1 = $farmer
@onready var farmer_2 = $farmer2

func set_up_farmers():
	farmer_1.set_up_before_battle()
	farmer_2.set_up_before_battle()
