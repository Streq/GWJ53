extends KinematicBody2D

signal pilot_entered(pilot)

signal dead()
signal revived()
signal in_water()
signal out_of_water()
export var jump := 100.0
export var velocity := Vector2()
export var jet_power := 200.0 
export var ground_friction := 100.0

export var damping := 0.0
export var gravity := 0.0

export var in_water := false setget set_in_water
export var water_gravity := -30.0
export var water_damping := 1.0

export var in_air := false
export var air_damping := 0.1
export var air_gravity := 50.0

onready var pivot: Node2D = $pivot
onready var input_state: InputState = $input_state
onready var pilot_seat: Node2D = $pivot/pilot_seat
onready var slots: Node2D = $pivot/slots

export var team := 0

export (float, -1.0, 1.0, 2.0) var facing_dir := 1.0 setget set_facing_dir

var dead = false

func set_in_water(val):
	if val == in_water:
		return
	in_water = val
	if in_water:
		emit_signal("in_water")
	else:
		emit_signal("out_of_water")

func _ready() -> void:
	set_facing_dir(facing_dir)

func set_facing_dir(val):
	val = sign(val)
	if val == 0.0 or facing_dir == val:
		return
	facing_dir = val

	if !is_inside_tree():
		return
	pivot.scale.x = abs(pivot.scale.x)*facing_dir

func _physics_process(delta: float) -> void:
	var direction = input_state.dir
#	velocity += direction*jet_power*delta
	
	if direction.x:
		set_facing_dir(direction.x)
		
	
	var _gravity = water_gravity if in_water else air_gravity if in_air else gravity
	velocity.y += _gravity*delta
	
	velocity = move_and_slide(velocity, Vector2.UP)
	if is_on_floor():
		velocity.x = move_toward(velocity.x,0.0,ground_friction*delta)
	
	var _damping = water_damping if in_water else air_damping if in_air else damping
	velocity *= 1-delta*_damping

func enter_pilot(pilot):
	pilot_seat.seat(pilot)
	emit_signal("pilot_entered", pilot)
	
func get_pilot():
	return pilot_seat.pilot

func die():
	dead = true
	emit_signal("dead")

func revive():
	dead = false
	emit_signal("revived")
