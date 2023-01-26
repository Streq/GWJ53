extends Node2D

signal pilot_on(new_pilot)
signal pilot_off(ejected_pilot)
signal occupied()
signal deoccupied()

var pilot = null

func seat(new_pilot):
	if owner.dead:
		return
	if is_instance_valid(pilot):
		return
	pilot = new_pilot
	pilot.set_physics_process(false)
	NodeUtils.reparent(pilot,self)
	pilot.position = Vector2()
	owner.facing_dir = pilot.facing_dir
	pilot.facing_dir = 1.0
	pilot.connect("dead",self,"unseat")
	emit_signal("pilot_on",new_pilot)
	emit_signal("occupied")

func unseat():
	yield(get_tree(),"physics_frame")
	if !is_instance_valid(pilot):
		return
	pilot.disconnect("dead",self,"unseat")
	pilot.facing_dir = owner.facing_dir
	pilot.set_physics_process(true)
	NodeUtils.reparent(pilot,owner.get_parent())
	pilot.global_position = global_position
	pilot.velocity = owner.velocity
	var ejected_pilot = pilot
	pilot = null
	emit_signal("pilot_off", ejected_pilot)
	emit_signal("deoccupied")

func unseat_on_frame():
	if !is_instance_valid(pilot):
		return
	pilot.disconnect("dead",self,"unseat")
	remove_child(pilot)
	var ejected_pilot = pilot
	emit_signal("pilot_off", ejected_pilot)
	emit_signal("deoccupied")

func eject():
	var ejected_pilot = pilot
	var direction = owner.input_state.dir
	yield(unseat(),"completed")
	ejected_pilot.velocity += direction*25.0

func _physics_process(delta: float) -> void:
	if owner.input_state.A.is_just_pressed():
		eject()
