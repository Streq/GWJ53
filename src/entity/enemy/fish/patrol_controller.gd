extends Node2D

export var stop_time := 10.0

export var patrol : NodePath

var points = []

var current = 0
var timer

enum {
	IDLE,
	MOVE
}

var state = MOVE

func _ready() -> void:
	owner = get_parent()
	points = get_node(patrol).get_children()
	timer = Timer.new()
	timer.wait_time = stop_time
	timer.process_mode = Timer.TIMER_PROCESS_PHYSICS
	timer.autostart = false
	timer.one_shot = true
	timer.connect("timeout",self,"move")
	add_child(timer)

func _physics_process(delta: float) -> void:
	match state:
		MOVE:
			var target = points[current].global_position
			if global_position.distance_squared_to(target)<100.0:
				owner.input_state.dir = Vector2()
				current = (current+1)%points.size()
				state = IDLE
				timer.start()
				return
			owner.input_state.dir = global_position.direction_to(points[current].global_position)
		IDLE:
			owner.input_state.dir = Vector2()

func move():
	state = MOVE
