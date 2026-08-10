extends StaticBody2D

@export var plr : int
@export var health : float = 1000.0
@onready var my_spr = $Sprite2D
@export var CHOCO_BULLET : PackedScene
@export var clone_number : int
var interval_attack_time : float = 1.0

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
	var tween_2 = create_tween()
	tween_2.set_trans(Tween.TRANS_LINEAR)
	tween_2.tween_property(my_spr, "modulate:a", 0.0, 0.25)
	await tween_2.finished
	queue_free()


func _on_farmer_collision_area_exited(area: Area2D) -> void:
	if area is Pineapple:
		pineapple_hit = false


func _on_detector_area_body_entered(body) -> void:
	if body is CharacterBody2D and body.plr != plr:
		if clone_number == 1:
			await Global.wait(interval_attack_time * 0.333)
			attack(body)
		if clone_number == 2:
			await Global.wait(interval_attack_time)
			attack(body)
		if clone_number == 3:
			await Global.wait(interval_attack_time * 0.667)
			attack(body)
		
func attack(body):
	while true:
		var choco_bullet = CHOCO_BULLET.instantiate()
		choco_bullet.position.y = position.y + 5
		choco_bullet.plr = plr
		var offset = 50 if plr == 1 else -50
		choco_bullet.position.x = position.x + offset
		choco_bullet.rotate_seed(body.global_position)
		get_node("/root/main_menu/farmer_frenzy/visual_effects").add_child(choco_bullet)
		await Global.wait(interval_attack_time)
