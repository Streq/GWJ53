extends Node
signal teleporting()
signal teleported()
func _ready() -> void:
	yield(get_parent(),"ready")
	if !get_parent().has_node("%teleport_action"):
		return
	var teleport_action = get_parent().get_node("%teleport_action")
	teleport_action.connect("teleporting",self,"teleporting")
	teleport_action.connect("teleported",self,"teleported")

func teleporting():
	emit_signal("teleporting")
func teleported():
	emit_signal("teleported")
