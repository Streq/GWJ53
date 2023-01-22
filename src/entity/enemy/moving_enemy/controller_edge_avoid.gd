extends Node2D

var moving_dir := 1.0

var frames_since_turn := 0
var GRACE_FRAMES := 3
onready var floor_detect: RayCast2D = $floor_detect

func _ready() -> void:
	yield(owner, "ready")
	moving_dir = owner.facing_dir

func _physics_process(delta: float) -> void:
	owner.input_state.dir = Vector2(moving_dir,0.0)
	if !floor_detect.is_colliding() or owner.is_on_wall():
		if frames_since_turn>GRACE_FRAMES:
			moving_dir = -moving_dir
		frames_since_turn = 0
	frames_since_turn += 1
	
