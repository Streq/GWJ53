extends Node

export var disabled := false setget set_disabled
export var dir := Vector2()

func set_disabled(val):
	disabled = val
	set_physics_process(!disabled)

func _physics_process(delta: float) -> void:
	get_parent().input_state.clear()
	get_parent().input_state.dir = dir
