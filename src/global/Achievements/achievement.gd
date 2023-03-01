extends Node
class_name Achievement

signal completed()

export var title := ""
export var description := ""
export var completed := false setget set_completed
export var icon_texture : Texture
export var hidden := false

func set_completed(val: bool):
	var updated := completed != val
	completed = val
	if completed and updated:
		emit_signal("completed")
	
