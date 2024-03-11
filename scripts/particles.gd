class_name Particles
extends Node2D

@export var particlespersecond := 10
@export var texture:Sprite2D
@export var startvelocity := Vector2(0,100)
@export var color := Color.WHITE
@export var lifetime := 5
var timer = Timer.new()
var particles:Array = []



func _ready():
	print("ready")
	#timer.connect("timeout",emitparticle)
	timer.timeout.connect(emitparticle)
	timer.wait_time = 1
	timer.start()
	emitparticle()
	pass 

func emitparticle():
	var newtexture:Sprite2D = texture.duplicate()
	add_child(newtexture)
	newtexture.global_position = global_position
	particles.append(newtexture)
	pass

func _process(delta):
#	after every timer tick add a sprite
	for particle in particles:
		particle.global_position += Vector2(0,1) * delta * 100
	pass
	
