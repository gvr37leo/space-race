extends Node
const ENEMY = preload("res://scenes/enemy.tscn")
var enemyskilled = 0
@onready var player = %player
var spawnrange = 1500

func _ready():
	spawnEnemy()
	pass # Replace with function body.

func on_enemy_died(enemy):
	enemyskilled += 1
	spawnEnemy()
	player.speedboostremaining += 3
#	give player speedboost

func spawnEnemy():
	var newenemy = ENEMY.instantiate()
	newenemy.global_position = Vector2(randf_range(1000,spawnrange),0).rotated(TAU * randf()) + player.global_position
	add_child(newenemy)

func _process(delta):
	#if(get_child_count() == 0):
		#await get_tree().create_timer(3).timeout
		#get_tree().change_scene_to_file("res://scenes/gamewon.tscn")
		#set_process(false)
	pass
