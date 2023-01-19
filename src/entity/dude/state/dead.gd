extends CharacterState
func _physics_update(delta):
	if root.in_water:
		goto("swim_dead")
		return
	if !root.is_on_floor():
		goto("air_dead")
		return
	root.velocity.x = move_toward(root.velocity.x, 0, root.horizontal_decceleration*delta)
	
	
