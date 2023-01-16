extends Node
func trigger():
	Shake.emit_signal("shake",Vector2.RIGHT.rotated(get_parent().global_rotation))
