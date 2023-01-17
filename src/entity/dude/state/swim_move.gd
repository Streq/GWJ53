extends CharacterState

onready var ship_enter: Node2D = $"%ship_enter"


func _physics_update(delta):
	if root.input_state.A.is_just_pressed():
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
	
	
#	if root.input_state.A.is_just_pressed():
#		root.velocity.y -= root.jump_speed
#		return
#
	
	if !root.input_state.dir:
		goto("swim_idle")
		return
		
	root.facing_dir = root.input_state.dir.x
	root.velocity += root.input_state.dir*root.swim_acceleration*delta
#	root.velocity = root.velocity.move_toward(root.input_state.dir*root.swim_speed, root.swim_acceleration*delta)
#	root.velocity.x = move_toward(root.velocity.x, 0, root.horizontal_decceleration*delta)
	
