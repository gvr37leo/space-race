extends CharacterBody2D
@onready var timer = $Timer
@onready var player:CharacterBody2D
const PROJECTILE = preload("res://scenes/subprojectile.tscn")
@onready var projectilecontainer
var health = 30
const DEATHEFFECT = preload("res://scenes/deatheffect.tscn")
var acceleration = 400
var maxspeed = 400
@onready var exhaustdown = $exhaustdown
@onready var exhaustleft = $exhaustleft
@onready var exhaustup = $exhaustup
@onready var exhaustright = $exhaustright
signal ondeath
@onready var enemycontainer
@export var accelrationCurve:Curve
var offset
@onready var marker = $marker

func _ready():
	player = get_node("/root/root/player")
	projectilecontainer = get_node("/root/root/projectilecontainer")
	enemycontainer = get_node("/root/root/enemycontainer")
	offset = Vector2(400,0).rotated(TAU * randf())
	pass

func _process(delta):
	var self2player = player.global_position - global_position
	
	if(global_position.distance_to(player.global_position) < 500 && timer.is_stopped()):
		var instance = PROJECTILE.instantiate()
		instance.rotation = self2player.angle()
		instance.global_position = global_position
		instance.velocity = self2player.normalized() * 300
		projectilecontainer.add_child(instance)
		timer.start()

	
	#instead of boosting directly towards the player
	#boost in the direction to have the velocity vector point towards the player as quickly as possible
	#also dont have the player as the goal but like a position next to the player
	#var goalspeedchange = (player.global_position - global_position).normalized() * maxspeed
	#var boostdir =  (goalspeedchange - velocity).normalized()
#
	#var self2target = (player.global_position + offset) - global_position
	#var direction = self2target.normalized()
	#var tempacc = Vector2(0,0)
	#if(self2target.length() > 100):
		##accelarate
		#if(goalspeedchange.length() > 10):
			#tempacc += boostdir * acceleration * delta
		#pass
	#else:
		##decellerate
		#if(velocity.length() > 5):
			#tempacc -= velocity.normalized() * acceleration * delta
		#pass
	#var dirdotvel = direction.dot(velocity.normalized())
	#dirdotvel = remap(dirdotvel,-1,1,0,1)
	#var curvevalue = accelrationCurve.sample(dirdotvel)
		
	#velocity += tempacc * curvevalue
	#if(velocity.length() > maxspeed):
			#velocity = velocity.limit_length(maxspeed)
	#var reverseacc = tempacc * -1
	
	marker.global_position = player.global_position + offset
	var self2target = to(global_position,player.global_position + offset)
	
		
	
	var goalspeed = self2target.normalized() * maxspeed
	if(self2target.length() < 100):
		goalspeed = player.velocity
	var desiredspeedchange = to(velocity,goalspeed)
	
	var oldvel = velocity
	velocity = velocity.move_toward(goalspeed,acceleration * delta)
	var velchange = to(oldvel,velocity)
	var reverseacc = velchange * -1
	exhaustleft.throttle = clamp(reverseacc.dot(Vector2(-1,0)),0,1) 
	exhaustright.throttle = clamp(reverseacc.dot(Vector2(1,0)),0,1) 
	exhaustup.throttle = clamp(reverseacc.dot(Vector2(0,-1)),0,1) 
	exhaustdown.throttle = clamp(reverseacc.dot(Vector2(0,1)),0,1) 
	
	
	move_and_slide()
	pass

func to(a,b) -> Vector2:
	return b - a
	
func take_damage(damage):
	health -= damage
	if(health <= 0):
		var instance = DEATHEFFECT.instantiate()
		instance.global_position = global_position
		instance.velocity = velocity
		get_node("/root/root").add_child(instance)
		queue_free()
		#ondeath.emit()
		enemycontainer.on_enemy_died(self)
	pass
