extends Node

func spawn():
	pass

func despawn():
	owner.queue_free()
