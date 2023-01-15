extends Node

func _physics_process(delta: float) -> void:
	if owner.input_state.dir:
		var direction = owner.input_state.dir
		direction.x*=owner.facing_dir
		get_parent().rotation = direction.angle()
