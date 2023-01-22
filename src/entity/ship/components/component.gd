extends Node2D
class_name ShipComponent
signal connected_to(slot)
signal disconnected_from(slot)
signal owned_by(ship)

signal trigger()
signal release()

export var type := ""
export var texture : Texture
export var label_name := ""

var slot = null


func connect_to_slot(new_slot):
	if is_instance_valid(slot):
		disconnect_from_slot()
	slot = new_slot
	slot.connect("trigger",self,"trigger")
	slot.connect("release",self,"release")
	transform = Transform2D.IDENTITY
	slot.add_component(self)
	emit_signal("connected_to",slot)
	emit_signal("owned_by",slot.owner)
	

func disconnect_from_slot():
	slot.disconnect("trigger",self,"trigger")
	slot.disconnect("release",self,"release")
	var disconnected_slot = slot
	slot.remove_component(self)
	slot = null
	emit_signal("disconnected_from", disconnected_slot)
	emit_signal("owned_by", null)
	
func trigger():
	emit_signal("trigger")
func release():
	emit_signal("release")

func _ready() -> void:
	if !owner:
		return
	yield(owner,"ready")
	if "type" in get_parent() and type == get_parent().type:
		connect_to_slot(get_parent())
	
