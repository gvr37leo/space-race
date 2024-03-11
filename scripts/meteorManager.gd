extends Node
@onready var assettemplates = $assettemplates
@onready var container = $container
@onready var player = %player
var tofaraway = 5000
var fillarea = 4000
var assets:Array
var desiredamount = 100
@onready var timer = $Timer

func _ready():
	assets = assettemplates.get_children()
	for i in range(desiredamount):
		var meteor = spawnMeteor()
		meteor.global_position = Utils.randVecInCircle() * fillarea + player.global_position
	pass



func _on_timer_timeout():
	deleteFarAway()
	fillEmptySpace()
	pass

func spawnMeteor():
	var original = choose(assets)
	var newitem := original.duplicate() as Sprite2D
	container.add_child(newitem)
	if(original.name.contains("meteor")):
		newitem.velocity = Utils.randVecInCircle().normalized() * 100
		newitem.rotation = newitem.velocity.angle() + TAU * 0.75
	else:
		newitem.velocity = Vector2(randf_range(-100,100),randf_range(-100,100))
		newitem.rotspeed = randf_range(-80,80)
	return newitem
	
func deleteFarAway():
	for child:Sprite2D in container.get_children():
		if(child.global_position.distance_to(player.global_position) > tofaraway):
			child.queue_free()

func fillEmptySpace():
	var amounttoadd = desiredamount - container.get_child_count()
	for i in range(amounttoadd):
		var meteor = spawnMeteor()
		var randompos = Utils.randVecInCircle() * fillarea
		if(randompos.length() < 1000):
			continue
		meteor.global_position = randompos + player.global_position
	pass

func _process(delta):
	pass
	
	
func choose(array:Array):
	var i = randi_range(0,array.size() - 1)
	return array[i]



