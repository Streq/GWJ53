extends Node


func _physics_process(delta: float) -> void:
	if owner.input_state.A.is_pressed():
		get_parent().release()
		return
	if owner.input_state.dir.x:
		get_parent().trigger()
	else:
		get_parent().release()
	
