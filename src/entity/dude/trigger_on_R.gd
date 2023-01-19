extends Node

func _physics_process(delta: float) -> void:
	if owner.input_state.R.is_just_pressed():
		get_parent().trigger()
	
