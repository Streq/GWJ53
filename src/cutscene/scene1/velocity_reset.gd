extends Node


func _physics_process(delta: float) -> void:
	get_parent().velocity = Vector2()
