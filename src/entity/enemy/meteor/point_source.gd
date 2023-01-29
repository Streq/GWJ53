extends Node2D


func get_point():
	var children = get_children()
	return get_child(randi()%children.size()).global_position
func get_points():
	var ret = []
	for c in get_children():
		ret.append(c.global_position)
	
	return ret
