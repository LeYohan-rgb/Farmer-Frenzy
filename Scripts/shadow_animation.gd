extends Area2D

class_name Avocado

var desired_position : Vector2
var my_gravity : float
var velocity : float
@onready var my_col_shape = $CollisionShape2D
@onready var shadow_spr = $Sprite2D
@onready var guacamole_spr = $guacamole
var life_span : float = 3.0 
@onready var my_timer = $Timer
#SCRIPTS


func _ready():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "scale", Vector2(0.5, 0.5), 1.0)
	
	await tween.finished
	
	scale = Vector2(1.0, 1.0)
	my_col_shape.disabled = false
	my_col_shape.show()
	shadow_spr.hide()
	my_timer.start(life_span - 0.5)
	my_timer.timeout.connect(disappear)
	var tween_2 = create_tween()
	tween_2.set_trans(Tween.TRANS_LINEAR)
	tween_2.tween_property(guacamole_spr, "modulate:a", 1.0, 0.5)
	
func disappear():
	var tween_2 = create_tween()
	tween_2.set_trans(Tween.TRANS_LINEAR)
	tween_2.tween_property(guacamole_spr, "modulate:a", 0.0, 0.5)
	await tween_2.finished
	queue_free()
	
	
