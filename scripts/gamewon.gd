extends Node2D
@onready var lastscore = $CanvasLayer/BoxContainer/lastscore
@onready var highscore = $CanvasLayer/BoxContainer/highscore


# Called when the node enters the scene tree for the first time.
func _ready():
	highscore.text = "fastest time: %.2f" % Global.fastesttime
	lastscore.text = "your time: %.2f" % Global.lasttime
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_button_down():
	get_tree().change_scene_to_file("res://node_2d.tscn")
	pass # Replace with function body.
