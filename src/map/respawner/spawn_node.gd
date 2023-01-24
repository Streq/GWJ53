extends Node2D

var prototype : Node = null
var current_instance : Node = null

func respawn():
	if is_instance_valid(current_instance):
		if current_instance.name == "terrain":
			breakpoint
	
		current_instance.queue_free()
	if is_instance_valid(prototype):
		current_instance = prototype.duplicate()
		get_parent().add_child_below_node(self, current_instance)
		
	pass
