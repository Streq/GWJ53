extends Node

export var player_path : NodePath
onready var player = get_node(player_path)


export var dir := Vector2()

func _physics_process(delta: float) -> void:
	if is_instance_valid(player):
		player.input_state.dir = dir

