extends Area2D
onready var talk_sign: Node2D = $talk_sign

onready var talked_to_locals: Node = $talked_to_locals


func _process(delta: float) -> void:
	var bodies = get_overlapping_bodies()
	if bodies:
		talk_sign.global_position = bodies[0].global_position
		set_process_unhandled_input(true)
		talk_sign.show()
	else:
		set_process_unhandled_input(false)
		talk_sign.hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("B") and is_instance_valid(talked_to_locals):
		talked_to_locals.trigger()
