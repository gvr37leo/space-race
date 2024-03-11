extends Node2D
var velocity = Vector2(0,0)
var lifetime = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += velocity * delta
	lifetime -= delta
	if(lifetime <= 0):
		queue_free()
	pass
