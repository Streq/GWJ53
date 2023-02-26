extends Node2D
var map = {}

export var disabled := false

func _ready() -> void:
#	if disabled:
#		for child in get_children():
#			child.queue_free()
#		return
	for child in get_children():
		map[child.name] = child
		

func play(sound, position_2d):
	if disabled:
		return
	return map[sound].play_at_position(position_2d)
