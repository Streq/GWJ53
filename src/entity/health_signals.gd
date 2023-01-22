extends Node
signal full()

func _ready() -> void:
	yield(get_parent(),"ready")
	if !get_parent().has_node("%health"):
		return
	var health = get_parent().get_node("%health")
	health.bar.connect("full",self,"full")

func full():
	emit_signal("full")
