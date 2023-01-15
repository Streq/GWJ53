extends Node

func _physics_process(delta: float) -> void:
	if owner.input_state.B.is_just_pressed():
		get_parent().trigger()
	else:
		get_parent().release()
	
