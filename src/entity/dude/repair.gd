extends CharacterState

onready var ship_enter: Node2D = $"%ship_enter"
onready var ship_repair: Node2D = $"%ship_repair"

func _enter(params):
	var ship = ship_repair.get_ship()
	if !ship:
		return
	ship_repair.repair_ship(ship)

func _exit():
	ship_repair.stop_repair_ship()

func _physics_update(delta):
	if root.input_state.A.is_just_pressed():
		var ship = ship_enter.get_ship()
		if ship:
			ship_enter.enter_ship(ship)
			return
	
	if root.in_water:
		goto("swim_idle")
		return
	
	if !root.is_on_floor():
		goto("air")
		return

	if root.input_state.A.is_just_pressed():
		root.velocity.y -= root.jump_speed
		return
		
	if !root.input_state.B.is_pressed() or !ship_repair.get_ship():
		goto("idle")
		return
	
	root.velocity.x = move_toward(root.velocity.x, 0, root.horizontal_decceleration*delta)
	
