extends StaticBody2D

@export var plr : int
@export var health : float = 1000.0
@onready var my_spr = $Sprite2D
@export var CHOCO_BULLET : PackedScene
@export var clone_number : int
@export var column_number : int
@onready var my_timer = $Timer
var interval_attack_time : float = 3.0
var life_span : float 
@onready var shoot_sfx = $shoot
@onready var detector_area = $detector_area/detection_area

#FRUIT VARIABLES
var pineapple_hit : bool = false

func _ready():
	if plr == 2:
		detector_area.position.x *= -1
		my_spr.flip_h = true
		
	if column_number == 1:
		health = Global.maximum_health / 8.0 #6.25
		life_span = 15.5 # 5 bullets
	if column_number == 2:
		health = Global.maximum_health / 9.6 #5.2083
		life_span = 12.5 # 4 bullets
	if column_number == 3:
		health = Global.maximum_health / 12.0 #4.1667
		life_span = 9.5 # 3 bullets 
	if column_number == 4:
		health = Global.maximum_health / 16.0 #3.125
		life_span = 6.5 # 2 bullets 

func _on_farmer_collision_area_entered(area: Area2D) -> void:
	if is_instance_valid(area) and area is Pineapple:
		pineapple_hit = true
		while health > 0 and pineapple_hit:
			receive_damage(area.damage, area.plr)
			await Global.wait(0.333)

func receive_damage(dmg : float, plr : int):
	health -= dmg
	if health <= 0:
		die()

func die():
	var tween_2 = create_tween()
	tween_2.set_trans(Tween.TRANS_LINEAR)
	tween_2.tween_property(my_spr, "modulate:a", 0.0, 0.25)
	await tween_2.finished
	queue_free()


func _on_farmer_collision_area_exited(area: Area2D) -> void:
	if is_instance_valid(area) and area is Pineapple:
		pineapple_hit = false


func _on_detector_area_body_entered(body) -> void:
	if is_instance_valid(body) and body is CharacterBody2D and body.plr != plr:
		my_timer.start(life_span)
		my_timer.timeout.connect(die)
		var tween_2 = create_tween()
		tween_2.set_trans(Tween.TRANS_LINEAR)
		tween_2.tween_property(my_spr, "modulate:a", 1.0, interval_attack_time * 0.333)
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
		if (plr == 1 and Global.player_1_health <= 0) or (plr == 2 and Global.player_2_health <= 0):
			return
			
		if !Global.is_in_farmer_fight:
			return
			
		var choco_bullet = CHOCO_BULLET.instantiate()
		choco_bullet.position.y = position.y + 5
		choco_bullet.plr = plr
		var offset = 50 if plr == 1 else -50
		choco_bullet.position.x = position.x + offset
		
		if !is_instance_valid(body):
			return
			
		choco_bullet.rotate_seed(body.global_position)
		get_node("/root/main_menu/farmer_frenzy/visual_effects").add_child(choco_bullet)
		shoot_sfx.play()
		await Global.wait(interval_attack_time)
		
