extends Node

func _physics_process(delta: float) -> void:
	if owner.input_state.B.is_pressed():
		get_parent().trigger()
	else:
		get_parent().release()
	
