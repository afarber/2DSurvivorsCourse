extends Camera2D


var target_position = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	acquire_target()
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * 10))


func acquire_target():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node == null:
		return
		
	target_position = player_node.global_position
