extends CharacterState
onready var duration: Timer = $duration

var timeout = false
func _ready():
	duration.connect("timeout",self,"timeout")

func _enter(params):
	timeout = false
	duration.start()
func _exit():
	duration.stop()

func _physics_update(delta:float) -> void:
	root.velocity *= 1-delta
	if timeout:
		goto(on_finish_goto_state)

func timeout():
	timeout = true
