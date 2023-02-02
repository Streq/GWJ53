extends Node


func _ready() -> void:
	yield(get_tree(),"idle_frame")
	if SessionState.get_component(SessionState.Components.DOWN):
		get_parent().trigger()
