extends Node2D

var moving_dir := 1.0

var frames_since_wall := 0
var GRACE_FRAMES := 3

func _ready() -> void:
	yield(owner, "ready")
	moving_dir = owner.facing_dir

func _physics_process(delta: float) -> void:
	owner.input_state.dir = Vector2(moving_dir,0.0)
	if owner.is_on_wall():
		if frames_since_wall>GRACE_FRAMES:
			moving_dir = -moving_dir
		frames_since_wall = 0
	frames_since_wall += 1
