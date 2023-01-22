extends Node2D


func _physics_process(delta: float) -> void:
	var player = Group.get_one("player")
	if !player:
		return
	owner.input_state.dir = player.global_position-owner.global_position
	
