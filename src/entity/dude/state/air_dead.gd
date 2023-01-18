extends CharacterState
func _physics_update(delta):
	if root.is_on_floor():
		goto("dead")
		return
