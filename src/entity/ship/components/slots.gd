extends Node2D

var map = {}
func _ready() -> void:
	for slot in get_children():
		map[slot.type] = slot
