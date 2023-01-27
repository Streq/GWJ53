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
	
	
#	if root.input_state.A.is_just_pressed():
#		root.velocity.y -= root.jump_speed
#		return
#
	var dir = root.input_state.dir
	if !dir:
		goto("swim_idle")
		return
		
	root.facing_dir = dir.x
	root.velocity += dir*root.swim_acceleration*delta
	if dir.y>0:
		root.velocity.y += dir.y*root.swim_acceleration*0.2*delta
#	root.velocity = root.velocity.move_toward(root.input_state.dir*root.swim_speed, root.swim_acceleration*delta)
#	root.velocity.x = move_toward(root.velocity.x, 0, root.horizontal_decceleration*delta)
	
