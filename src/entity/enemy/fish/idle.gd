extends CharacterState


func _physics_update(delta:float) -> void:
	if root.in_water:
		if root.input_state.dir:
			root.facing_dir = root.input_state.dir.x
			goto("move")
			return
		root.velocity.x = move_toward(root.velocity.x, 0, root.swim_acceleration*delta)
		root.velocity.y = move_toward(root.velocity.y, 0, root.swim_acceleration*delta)
	pass
