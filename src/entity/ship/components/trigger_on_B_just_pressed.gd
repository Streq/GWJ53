extends Node
onready var hurt_invincibility: Node = $"%hurt_invincibility"

func _physics_process(delta: float) -> void:
#	if owner.input_state.B.is_pressed() and !hurt_invincibility.active:
	if owner.input_state.B.is_pressed():
		get_parent().trigger()
	else:
		get_parent().release()
	
