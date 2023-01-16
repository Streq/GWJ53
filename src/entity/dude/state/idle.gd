extends CharacterState
func _physics_update(delta):
	if root.in_water:
		goto("swim_idle")
		return
	
	if !root.is_on_floor():
		goto("air")
		return
	
	if root.input_state.A.is_just_pressed():
		root.velocity.y -= root.jump_speed
		return
	
	if root.input_state.dir.x:
		root.facing_dir = root.input_state.dir.x
		goto("run")
		return
	
	root.velocity.x = move_toward(root.velocity.x, 0, root.horizontal_decceleration*delta)
	
