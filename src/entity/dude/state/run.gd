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
	
	if !root.input_state.dir.x:
		goto("idle")
		return

	root.facing_dir = root.input_state.dir.x
	root.velocity.x = move_toward(root.velocity.x, root.speed*root.facing_dir, root.horizontal_acceleration*delta)
	
	
