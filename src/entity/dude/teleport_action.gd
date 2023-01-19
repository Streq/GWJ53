extends Node
onready var teleport_animation: AnimationPlayer = $"../teleport_animation"


func trigger():
	if !Group.exists("teleporter") or owner.dead or !owner.is_physics_processing():
		return
	owner.set_physics_process(false)
	teleport_animation.play("teleport")
	yield(teleport_animation,"animation_finished")
	
	owner.set_physics_process(true)
	teleport()
	owner.state_machine._change_state("idle")
	teleport_animation.play("deteleport")
	yield(teleport_animation,"animation_finished")
	
#	owner.set_physics_process(true)

func teleport():
	Group.get_one("teleporter").teleport()
