extends Node2D

signal pilot_on(new_pilot)
signal pilot_off(ejected_pilot)
var pilot = null

func seat(new_pilot):
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

func unseat():
	if !is_instance_valid(pilot):
		return
	pilot.facing_dir = owner.facing_dir
	NodeUtils.reparent(pilot,owner.get_parent())
	pilot.set_physics_process(true)
	pilot.global_position = global_position
	pilot.velocity = owner.velocity
	pilot.disconnect("dead",self,"unseat")
	var ejected_pilot = pilot
	pilot = null
	emit_signal("pilot_off", ejected_pilot)

func eject():
	var ejected_pilot = pilot
	var direction = owner.input_state.dir
	unseat()
	ejected_pilot.velocity += direction*25.0

func _physics_process(delta: float) -> void:
	if owner.input_state.A.is_just_pressed():
		eject()
