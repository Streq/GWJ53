extends CharacterState


func _physics_update(delta:float) -> void:
	if !root.in_water or !root.input_state.dir:
		goto("idle")
		
	root.velocity.x = move_toward(root.velocity.x, root.input_state.dir.x*root.swim_speed, root.swim_acceleration*delta)
	root.velocity.y = move_toward(root.velocity.y, root.input_state.dir.y*root.swim_speed, root.swim_acceleration*delta)
	root.facing_dir = root.input_state.dir.x
	
	pass
