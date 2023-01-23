extends Node
signal heal()
var pilot = null
onready var heal_cooldown: Timer = $heal_cooldown

func trigger(new_pilot:Node) -> void:
	pilot = new_pilot
	heal_cooldown.start()

func pilot_exited():
	pilot = null

func heal():
	if !heal_cooldown.is_stopped():
		return
	if !is_instance_valid(pilot) or !pilot.has_node("%health"):
		return
	var pilots_health = pilot.get_node("%health")
	heal_cooldown.start()

	if pilots_health.is_full():
		return

	pilots_health.heal(1.0)
	emit_signal("heal")

func _ready() -> void:
	heal_cooldown.connect("timeout",self,"heal")
