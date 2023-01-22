extends Node
signal teleporting
signal teleported
onready var teleport_animation: AnimationPlayer = $"../teleport_animation"
onready var pickup_grabber: Node2D = $"../pivot/pickup_grabber"

func trigger():
	if !Group.exists("teleporter") or owner.dead or !owner.is_physics_processing():
		return
#	pickup_grabber.drop()
	emit_signal("teleporting")
	pickup_grabber.disabled = true
	owner.set_physics_process(false)
	teleport_animation.play("teleport")
	yield(teleport_animation,"animation_finished")
	owner.set_physics_process(true)
	var teleported = false
	if !owner.dead:
		teleport()
		teleported = true
	owner.state_machine._change_state("idle")
	teleport_animation.play("deteleport")
	yield(teleport_animation,"animation_finished")
	pickup_grabber.disabled = false
	if teleported:
		emit_signal("teleported")
#	owner.set_physics_process(true)

func teleport():
	Group.get_one("teleporter").teleport()
