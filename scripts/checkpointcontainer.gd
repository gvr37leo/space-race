extends Node
@onready var graypivot = %graypivot
@onready var yellowpivot = %yellowpivot
var checkpointindex = 0
var amount = 10
const CHECKPOINT = preload("res://scenes/checkpoint.tscn")
@onready var player:CharacterBody2D = %player
@onready var checkpointtext = %checkpointtext
var time = 0
var finished = false

func _ready():
	checkpointtext.text = str(checkpointindex) + "/"  + str(amount)
	for i in range(amount):
		var newcheckpoint = CHECKPOINT.instantiate()
		newcheckpoint.global_position = Utils.randVecInCircle() * 1000
		newcheckpoint.visible = false
		add_child(newcheckpoint)
	var checkpoints = get_children()
	checkpoints[0].visible = true
	pass # Replace with function body.

func checkpointhit(checkpoint,player):
	checkpoint.visible = false
	checkpointindex += 1
	checkpointtext.text = str(checkpointindex) + "/"  + str(amount)
	if(checkpointindex >= amount):
		finished = true
		if(time < Global.fastesttime):
			Global.fastesttime = time
		Global.lasttime = time
		yellowpivot.visible = false
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://scenes/gamewon.tscn")
		return
	
	var checkpoints = get_children()
	checkpoints[checkpointindex].visible = true
	
		
	pass
@onready var timelabel = %timelabel

func _process(delta):
	if(finished == false):
		time += delta
		timelabel.text = "time %.2f" % time
	if(checkpointindex >= amount):
		return
	var checkpoints = get_children()
	var current = checkpoints[checkpointindex]
	var mainangle = player.global_position.angle_to_point(current.global_position)
	yellowpivot.rotation = mainangle
	
	var checkpoint2player = player.global_position - current.global_position
	yellowpivot.modulate.a = clamp(remap(checkpoint2player.length(),1000,500,1,0),0,1)
	if(checkpointindex < amount - 1):
		var next = checkpoints[checkpointindex + 1]
		var secondangle = player.global_position.angle_to_point(next.global_position)
		graypivot.rotation = secondangle
		graypivot.visible = true
	else:
		graypivot.visible = false
	pass
