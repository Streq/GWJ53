extends CharacterState
func _physics_update(delta):
	if !root.in_water:
		goto("air_dead")
		return
	if root.is_on_floor():
		goto("dead")
		return
