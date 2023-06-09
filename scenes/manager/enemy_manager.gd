extends Node

const SPAWN_RADIUS = 350

@export var basic_enemy_scene: PackedScene


func _ready():
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node == null:
		return
	
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = player_node.global_position + SPAWN_RADIUS * random_direction
	var enemy = basic_enemy_scene.instantiate() as Node2D
	enemy.global_position = spawn_position
	get_parent().add_child(enemy)
