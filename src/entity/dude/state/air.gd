extends CharacterState
onready var ledge_grab: Node2D = $"%ledge_grab"
onready var ship_enter: Node2D = $"%ship_enter"
onready var hurtbox: Area2D = $"%hurtbox"

signal landed()

export var COYOTE_JUMP_FRAMES := 5
var coyote_jump_frames := 0

func _enter(params):
	if params and params[0] == "coyote":
		coyote_jump_frames = COYOTE_JUMP_FRAMES
#		print("can_coyote_jump")
	else:
		coyote_jump_frames = 0

func _physics_update(delta):
	if root.input_state.L.is_just_pressed():
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
	
	#horizontal air braking
	var dir = root.input_state.dir
	if dir.x and root.in_air and (
		sign(root.velocity.x) != sign(dir.x) or
		abs(root.velocity.x) < abs(root.speed)
	):
		root.velocity.x = move_toward(root.velocity.x, dir.x*root.speed, root.horizontal_air_acceleration*delta)
		
	if coyote_jump_frames > 0:
#		print(coyote_jump_frames)
		coyote_jump_frames -= 1
		if root.input_state.A.is_just_pressed():
			root.velocity.y = -root.jump_speed
#			print("coyote_jump")
			coyote_jump_frames = 0
			return
	
	var ledge = ledge_grab.get_ledge()
	if ledge != null:
		goto_args("ledge_up",[ledge])
		return
