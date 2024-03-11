extends CharacterBody2D


var speed = 200.0
const PROJECTILE = preload("res://scenes/projectile.tscn")
@onready var timer = $Timer
@onready var leftcannon = $leftcannon
@onready var rightcannon = $rightcannon
var cannonshotindex = 0
@onready var projectilecontainer = %projectilecontainer
var health = 100
@onready var engine_exhaust = $engineExhaust
var acceleration = 300
@onready var speedlabel = $"../CanvasLayer/speed"
var maxspeed = 600
@export var accelrationCurve:Curve
var speedboostremaining = 0
@onready var boost = %boost

func _ready():
	pass	
	
func take_damage(damage):
	health -= damage
	if(health <= 0):
		get_tree().change_scene_to_file("res://scenes/gameover.tscn")
		pass

func _process(delta):
	boost.text = "boost %.1f" % abs(speedboostremaining)
	
	# point towards cursor
	var mouse_pos = get_global_mouse_position()
	var node_pos = get_global_position()
	var direction = mouse_pos - node_pos
	direction = direction.normalized()
	var rotation = direction.angle()
	rotation_degrees = rad_to_deg(rotation) + 90
	
	
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && timer.is_stopped()):
		var instance = PROJECTILE.instantiate()
		if(cannonshotindex % 2 == 0):
			instance.global_position = leftcannon.global_position
		else:
			instance.global_position = rightcannon.global_position
		cannonshotindex += 1
		instance.rotation = rotation
		instance.speed += speed
		instance.velocity = velocity + -transform.y * 3200
		projectilecontainer.add_child(instance)
		timer.start()
		pass
		
	engine_exhaust.throttle = 0
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT)):
		engine_exhaust.throttle = 1
		var dirdotvel = direction.dot(velocity.normalized())
		dirdotvel = remap(dirdotvel,-1,1,0,1)
		var curvevalue = accelrationCurve.sample(dirdotvel)
		
		var boostmultiplier = 1
		if(speedboostremaining > 0):
			speedboostremaining -= delta
			boostmultiplier = 3
		velocity += direction * acceleration * curvevalue * boostmultiplier * delta
		if(velocity.length() > maxspeed):
			velocity = velocity.limit_length(maxspeed)
		pass
		
	
	move_and_slide()
		
	if(Input.is_key_label_pressed(KEY_ESCAPE)):
		get_tree().quit()
