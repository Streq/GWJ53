extends Sprite


func _physics_process(delta:float) -> void:
	position = owner.input_state.dir
	pass
