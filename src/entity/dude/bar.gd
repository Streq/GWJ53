extends Node
signal value_changed(value, max_value)
signal empty
signal full

export var value := 100.0 setget set_value
export var max_value := 100.0 setget set_max_value

func set_value(val):
	value = clamp(val, 0, max_value)
	emit_signal("value_changed", value, max_value)
	if !value:
		emit_signal("empty")
	if value == max_value:
		emit_signal("full")
func set_max_value(val):
	max_value = val
	set_value(value)
