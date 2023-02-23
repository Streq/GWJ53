extends Node

func get_point():
	return owner.global_position + randf()*200.0*Vector2.RIGHT.rotated(randf()*TAU)
