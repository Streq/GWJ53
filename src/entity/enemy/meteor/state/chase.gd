extends CharacterState


onready var duration: Timer = $duration
var done = false
func _ready() -> void:
	duration.connect("timeout",self,"finish")

func _enter(params):
	done = false
	duration.start()

func _exit():
	duration.stop()

func _physics_update(delta:float) -> void:
	if done:
		goto(on_finish_goto_state)
		return
	
	root.velocity += root.input_state.dir*root.speed*10*delta
	root.velocity *= 1-delta
	
func finish():
	done = true
