extends Sprite

enum STATE {
	LOOK_AT,
	STARE,
	CENTER,
	ROTATE
}

export (STATE) var state

var time = 0.0

func _physics_process(delta:float) -> void:
	match state:
		STATE.LOOK_AT:
			position = owner.input_state.dir
		STATE.STARE:
			pass
		STATE.CENTER:
			position = Vector2()
		STATE.ROTATE:
			time += delta*PI*2
			position = Vector2.RIGHT.rotated(time)
		
	pass
func look_at(global_pos):
	position = global_position.direction_to(global_pos)
