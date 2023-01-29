extends Node2D

export var enabled := true setget set_enabled

func set_enabled(val):
	if enabled != val:
		return
	enabled = val
	set_physics_process(enabled)

func _physics_process(delta: float) -> void:
	var player = Group.get_one("player")
	if !player:
		return
	owner.input_state.dir = player.global_position-owner.global_position
	owner.input_state.B.pressed = !owner.input_state.B.pressed
#	print(owner.input_state.B.pressed)
