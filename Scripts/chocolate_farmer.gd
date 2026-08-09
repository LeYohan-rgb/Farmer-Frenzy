extends StaticBody2D

@export var plr : int
@export var health : float = 1000.0

#FRUIT VARIABLES
var pineapple_hit : bool = false

func _on_farmer_collision_area_entered(area: Area2D) -> void:
	if area is Pineapple:
		pineapple_hit = true
		while health > 0 and pineapple_hit:
			receive_damage(area.damage, area.plr)
			await Global.wait(0.333)
			


func receive_damage(dmg : float, plr : int):
	pass

func die():
	pass


func _on_farmer_collision_area_exited(area: Area2D) -> void:
	if area is Pineapple:
		pineapple_hit = false
