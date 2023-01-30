extends Node
func _ready() -> void:
	get_parent().owner = get_parent().get_parent()
	queue_free()
