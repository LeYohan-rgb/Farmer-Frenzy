extends Area2D

@export var plr : int = 0
signal hit(dmg : int)

@onready var spr = $Sprite2D
@onready var block_sound = $block_audio

func _ready() -> void:
	if plr == 2:
		spr.scale.x *= -1




func _on_area_entered(area: Area2D) -> void:
	if !is_instance_valid(area):
		return
		
	if area.is_in_group("projectile") and area.plr != plr:
		hit.emit(area.damage)
		block_sound.play()
		area.queue_free()
