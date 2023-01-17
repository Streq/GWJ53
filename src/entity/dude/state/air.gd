extends CharacterState
onready var ledge_grab: Node2D = $"%ledge_grab"
onready var ship_enter: Node2D = $"%ship_enter"

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
		goto("idle")
		return
	
	
	var ledge = ledge_grab.get_ledge()
	if ledge != null:
		goto_args("ledge_up",[ledge])
		return
