extends Node2D

func _physics_process(delta: float) -> void:
	global_rotation = (-owner.velocity).angle()
