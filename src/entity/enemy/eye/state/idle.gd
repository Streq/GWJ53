extends CharacterState


func _physics_update(delta:float) -> void:
	root.velocity += root.input_state.dir*root.speed*delta
	if root.input_state.A.is_just_pressed():
		goto("spawning")
		return
	if root.input_state.B.is_just_pressed():
		goto("tackle_warmup")
		return
	if root.input_state.L.is_just_pressed():
		goto("chase")
		return
	if root.input_state.R.is_just_pressed():
		goto("shoot_warmup")
		return
	
