extends Node2D
@onready var debris = $debris
@onready var debris_2 = $debris2
@onready var debris_3 = $debris3
@onready var boom = $boom
var velocity = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	debris.emitting = true
	debris_2.emitting = true
	debris_3.emitting = true
	boom.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += velocity * delta
	pass
