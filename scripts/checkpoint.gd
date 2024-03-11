extends Node2D
#CHECKPOINT.GD
var checkpointcontainer


# Called when the node enters the scene tree for the first time.
func _ready():
	checkpointcontainer = get_node("/root/root/checkpointcontainer")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(player):
	if(visible):
		checkpointcontainer.checkpointhit(self,player)
	pass # Replace with function body.
