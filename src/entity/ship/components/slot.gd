extends Node2D
class_name ShipSlot

export var type := ""

var component = null

signal trigger()
signal release()

signal coupled()
signal decoupled()

var coupled := false

func trigger():
	emit_signal("trigger")
func release():
	emit_signal("release")

func swap_in(new_component):
	pass

func add_component(new_component):
	component = new_component
	coupled = true
	emit_signal("coupled")
	
func remove_component(component):
	coupled = false
	emit_signal("decoupled")
