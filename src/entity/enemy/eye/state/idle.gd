extends CharacterState


func _physics_update(delta:float) -> void:
	root.velocity += root.input_state.dir*root.speed*delta
	
	pass
