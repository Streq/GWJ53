extends Node2D
func _physics_process(delta: float) -> void:
	var pilot = owner.get_pilot()
	if !is_instance_valid(pilot):
		return
	pilot.get_node("%oxygen").fill(100.0)
