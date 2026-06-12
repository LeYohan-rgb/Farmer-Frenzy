extends Node2D

@onready var farmer_1 = $farmer
@onready var farmer_2 = $farmer2

func set_up_farmers():
	farmer_1.position = Vector2(128, 360)
	farmer_2.position = Vector2(1024, 360)
	farmer_1.set_up_before_battle()
	farmer_2.set_up_before_battle()

func quitting_game():
	farmer_1.quit_game()
	farmer_2.quit_game()
