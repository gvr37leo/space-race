extends Node2D
@export var throttle = 0
@onready var fire = $fire
@onready var exhaustfire = $Exhaustfire
@onready var rumble = $rumble
var targetscale = 0
var current = 0
var changespeed = 5
@export var playsound = false


# Called when the node enters the scene tree for the first time.
func _ready():
	if(playsound):
		rumble.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	targetscale = throttle
	current = move_toward(current,targetscale,delta * changespeed)
	if(throttle > 0.5):
		fire.emitting = true
	else:
		fire.emitting = false
	
	exhaustfire.scale = Vector2.ONE * current * 1.5
	rumble.volume_db = linear_to_db(throttle)
	pass
