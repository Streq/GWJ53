extends Node2D
class_name ShipComponent
signal connected_to(slot)
signal disconnected_from(slot)

signal trigger()
signal release()

export var type := ""

var slot = null


func connect_to_slot(new_slot):
	if is_instance_valid(slot):
		disconnect_from_slot()
	slot = new_slot
	transform = Transform2D.IDENTITY
	emit_signal("connected_to",slot)

func disconnect_from_slot():
	var disconnected_slot = slot
	slot = null
	emit_signal("disconnected_from", disconnected_slot)

func trigger():
	emit_signal("trigger")
func release():
	emit_signal("release")
