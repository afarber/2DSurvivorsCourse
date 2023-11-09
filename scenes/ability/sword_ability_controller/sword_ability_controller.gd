extends Node


const MAX_RANGE = 150


@export var sword_ability:PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node == null:
		return
		
	# find all enemies with MAX_RANGE distance to the player
	var enemies = get_tree().get_nodes_in_group("enemy").filter(func(enemy: Node2D): 
		return enemy.global_position.distance_squared_to(player_node.global_position) < MAX_RANGE * MAX_RANGE
	)
	if enemies.size() == 0:
		return
		
	enemies.sort_custom(func(a: Node2D, b: Node2D):
		var a_distance = a.global_position.distance_squared_to(player_node.global_position)
		var b_distance = b.global_position.distance_squared_to(player_node.global_position)
		return a_distance < b_distance
	)
		
	var sword_instance = sword_ability.instantiate() as Node2D
	player_node.get_parent().add_child(sword_instance)
	sword_instance.global_position = enemies[0].global_position
	sword_instance.global_position += 4 * Vector2.RIGHT.rotated(randf_range(0, TAU))
	
	var enemy_direction = enemies[0].global_position - sword_instance.global_position
	sword_instance.rotation = enemy_direction.angle()
	
	
