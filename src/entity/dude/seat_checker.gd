extends Node

func _ready() -> void:
	if !owner:
		return
	if !owner.get_parent():
		return
	
	var maybe_ship = owner.get_parent()
	yield(maybe_ship,"ready")
	if maybe_ship.has_method("enter_pilot"):
		maybe_ship.enter_pilot(owner)
