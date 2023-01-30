extends CharacterState
onready var warmup_time: Timer = $warmup_time
onready var cooldown_time: Timer = $cooldown_time

signal warmup_done()
signal shoot()

export var toward_velocity := -3.0
export var shots := 1
export var pause_between_shots := 0.5
var current_shots_taken := 0

func _ready() -> void:
	cooldown_time.wait_time = pause_between_shots
	warmup_time.connect("timeout", self, "warmup_done")

func _enter(params):
	root.velocity = Vector2()
	warmup_time.start()
	current_shots_taken = 0
	
func _exit() -> void:
	warmup_time.stop()
	cooldown_time.stop()

func _physics_update(delta:float) -> void:
	if !warmup_time.is_stopped():
		return
	
	if !cooldown_time.is_stopped():
		return
	
	current_shots_taken += 1
	emit_signal("shoot")
	cooldown_time.start()
		
	if current_shots_taken >= shots:
		goto(on_finish_goto_state)
		return
	

func warmup_done():
	emit_signal("warmup_done")

