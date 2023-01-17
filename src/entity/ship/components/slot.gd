extends Node2D
class_name ShipSlot

export var type := ""

var component = null

signal trigger()
signal release()

func trigger():
	emit_signal("trigger")
func release():
	emit_signal("release")

func swap_in(new_component):
	pass
