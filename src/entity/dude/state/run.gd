extends CharacterState
onready var ship_enter: Node2D = $"%ship_enter"
onready var ship_repair: Node2D = $"%ship_repair"

onready var hurt_invincibility: Node = $"%hurt_invincibility"
func _physics_update(delta):
	if root.input_state.L.is_just_pressed():
		var ship = ship_enter.get_ship()
		if ship:
			ship_enter.enter_ship(ship)
			return

	if root.in_water:
		goto("swim_idle")
		return
	
	
	if !root.is_on_floor():
		if root.input_state.A.is_just_pressed():
			root.velocity.y -= root.jump_speed
			goto("air")
#			print("precoyote_jump")
			return
		goto_args("air",["coyote"])
		return
	
	if root.input_state.A.is_just_pressed():
		root.velocity.y -= root.jump_speed
		goto("air")
		return

	if root.input_state.B.is_just_pressed() and !hurt_invincibility.active:
		var ship = ship_repair.get_ship()
		if ship:
			goto("repair")
			return

	if !root.input_state.dir.x:
		goto("idle")
		return

	root.facing_dir = root.input_state.dir.x
	root.velocity.x = move_toward(root.velocity.x, root.speed*root.facing_dir, root.horizontal_acceleration*delta)
	
	
