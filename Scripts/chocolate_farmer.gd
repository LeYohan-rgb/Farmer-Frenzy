extends StaticBody2D



func _on_farmer_collision_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectile"):
		area.queue_free()
