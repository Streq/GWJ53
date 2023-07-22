extends Node

func trigger():
	get_tree().quit()

func _ready() -> void:
	if !OS.has_feature("pc"):
		get_parent().queue_free()
