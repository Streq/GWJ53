extends CharacterState
onready var ledge_grab: Node2D = $"%ledge_grab"
onready var ship_enter: Node2D = $"%ship_enter"
onready var hurtbox: Area2D = $"%hurtbox"

signal landed()

func _physics_update(delta):
	if root.input_state.A.is_just_pressed():
		var ship = ship_enter.get_ship()
		if ship:
			ship_enter.enter_ship(ship)
			return
	
	if root.in_water:
		goto("swim_idle")
		return
	
	
	if root.is_on_floor():
		if root.previous_velocity.y > 90.0:
			hurtbox.take_damage(floor((root.previous_velocity.y-90.0)/30.0)+1.0)
		goto("idle")
		emit_signal("landed")
		return
	
	
	var ledge = ledge_grab.get_ledge()
	if ledge != null:
		goto_args("ledge_up",[ledge])
		return
