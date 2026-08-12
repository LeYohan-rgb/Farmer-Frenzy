extends Area2D

@export var plr : int
@onready var spr = $Sprite2D
@onready var reflect_sfx = $reflect_audio

func _ready():
	if plr == 2:
		spr.scale.x *= 1



func _on_area_entered(area: Area2D) -> void:
	if !is_instance_valid(area):
		return
		
	if area.is_in_group("projectile") and area.plr != plr:
		print("okay")
		area.rotate_seed(Vector2(300, 300))
		reflect_sfx.play()
