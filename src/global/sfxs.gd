extends Node2D
var map = {}
func _ready() -> void:
	for child in get_children():
		map[child.name] = child
		

func play(sound,position_2d):
	map[sound].play(position_2d)
