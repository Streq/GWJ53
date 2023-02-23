extends Node
signal teleport()
onready var fade: AnimationPlayer = $"%fade"

onready var point_source = $default_teleport_point_source

func set_custom_point_source(custom_point_source):
	point_source = custom_point_source


func teleport():
	owner.set_physics_process(false)
	fade.play("fade_out")
	yield(fade, "animation_finished")
	var point = point_source.get_point()
	owner.global_position = point
	emit_signal("teleport")
	fade.play("fade_in")
	yield(fade, "animation_finished")
	owner.set_physics_process(true)
	pass

