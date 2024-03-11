extends Node2D
@onready var front = $front
@export var speed = 200
@onready var boom = $boom
@onready var timer = $Timer
@onready var pew = $pew
var damage = 10
var velocity = Vector2(0,0)

const PROJECTILE_IMPACT = preload("res://scenes/projectile_impact.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pew.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#global_position += transform.x * delta * speed
	global_position += velocity * delta
	pass
	
func _on_area_2d_body_entered(body):
	var instance = PROJECTILE_IMPACT.instantiate()
	instance.global_position = front.global_position
	instance.velocity = body.velocity
	get_node("/root/root").add_child(instance)
	body.take_damage(damage)
	queue_free()
	pass # Replace with function body.


func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.



