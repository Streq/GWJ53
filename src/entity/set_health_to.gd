extends Node


export var value := 1.0
export var max_value := -1.0

func _ready() -> void:
#	trigger()
	pass

func trigger():
	if !get_parent().has_node("%health"):
		return
	var health = get_parent().get_node("%health")
	if max_value > 0.0:
		health.bar.max_value = max_value
	if value > 0.0:
		health.bar.value = value
	
