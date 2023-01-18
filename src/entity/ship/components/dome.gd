extends Node2D
onready var wearer = owner.owner
func _physics_process(delta: float) -> void:
	if is_instance_valid(wearer):
		var pilot = wearer.get_pilot()
		if !is_instance_valid(pilot):
			return
		pilot.get_node("%oxygen").fill(100.0)
