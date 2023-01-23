extends Node
signal teleporting
signal teleported
onready var teleport_animation: AnimationPlayer = $"../teleport_animation"
onready var pickup_grabber: Node2D = $"../pivot/pickup_grabber"

var abort = false
var ongoing = false
func trigger():
	if ongoing:
		return
	if !Group.exists("teleporter") or owner.dead or !owner.is_physics_processing():
		return
#	pickup_grabber.drop()
	ongoing = true
	emit_signal("teleporting")
	
	owner.connect("dead",self,"abort")
	owner.set_physics_process(false)
	pickup_grabber.disabled = true
	
	teleport_animation.play("teleport")
	yield(teleport_animation,"animation_finished")
	
	owner.disconnect("dead",self,"abort")
	owner.set_physics_process(true)
	pickup_grabber.disabled = false
	
	if abort:
		clean_up()
		return
		
	teleport()
	
	owner.state_machine._change_state("idle")
	teleport_animation.play("deteleport")
	yield(teleport_animation,"animation_finished")
	clean_up()
	emit_signal("teleported")
#	owner.set_physics_process(true)

func teleport():
	Group.get_one("teleporter").teleport()

func abort():
	abort = true

func clean_up():
	abort = false
	ongoing = false
	
