extends CharacterState

onready var ship_enter: Node2D = $"%ship_enter"


func _physics_update(delta):
	if root.input_state.L.is_just_pressed():
		var ship = ship_enter.get_ship()
		if ship:
			ship_enter.enter_ship(ship)
			return
	
	if !root.in_water:
		if !root.is_on_floor():
			goto("air")
			return
		
		goto("idle")
		return

	if root.input_state.dir:
		root.facing_dir = root.input_state.dir.x
		goto("swim_move")
		return

