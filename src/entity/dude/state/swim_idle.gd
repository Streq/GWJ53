extends CharacterState
func _physics_update(delta):
	if !root.in_water:
		if !root.is_on_floor():
			goto("air")
			return
		
		goto("idle")
		return

	if root.input_state.dir:
		root.facing_dir = root.input_state.dir.x
		goto("swim_move")
		return

