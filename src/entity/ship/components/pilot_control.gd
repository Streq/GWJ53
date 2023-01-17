extends Node

var pilot = null

func _ready() -> void:
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	owner.input_state.copy_from(pilot.input_state)
	

func _on_pilot_on(new_pilot) -> void:
	pilot = new_pilot
	set_physics_process(true)

func _on_pilot_off(ejected_pilot) -> void:
	pilot = null
	owner.input_state.clear()
	set_physics_process(false)
