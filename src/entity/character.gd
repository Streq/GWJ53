extends KinematicBody2D
signal in_water()
signal out_of_water()



onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var state_machine: Node = $state_machine
onready var pivot: Node2D = $pivot
onready var input_state: Node = $input_state

export var velocity := Vector2()

export var speed = 75.0

export var jump_speed = 100.0

export var gravity = 100.0
export var water_gravity := -30.0

export var damping := 0.0
export var water_damping := 1.0

export var max_fall_speed := 100.0

export var horizontal_acceleration := 500.0
export var horizontal_air_acceleration := 200.0
export var horizontal_decceleration := 500.0
export var horizontal_air_decceleration := 10.0
export var swim_speed := 30.0
export var swim_acceleration := 300.0

var in_water := false setget set_in_water

func set_in_water(val):
	if val == in_water:
		return
	in_water = val
	if in_water:
		emit_signal("in_water")
	else:
		emit_signal("out_of_water")

#export var health := 3
#export var max_health := 3
#export var invulnerable := false
#export var pass_through := false
#export var team := 0


export (float, -1.0, 1.0, 2.0) var facing_dir := 1.0 setget set_facing_dir

func set_facing_dir(val):
	val = sign(val)
	if val == 0.0 or facing_dir == val:
		return
	facing_dir = val

	if !is_inside_tree():
		return
	pivot.scale.x = abs(pivot.scale.x)*facing_dir


func _ready() -> void:
	state_machine.initialize()

func _physics_process(delta: float) -> void:
	velocity = move_and_slide(velocity, Vector2.UP)
	
	var _gravity = gravity if !in_water else water_gravity
	velocity.y += _gravity*delta
	var _damping = damping if !in_water else water_damping
	velocity *= 1-delta*_damping
	
	state_machine.physics_update(delta)
