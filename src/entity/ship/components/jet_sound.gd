extends AudioStreamPlayer2D

func play(from_position:= 0.0):
	if playing:
		return
	else:
		.play(from_position)
