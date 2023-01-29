extends CharacterState
onready var duration: Timer = $duration
var done = false
func _ready() -> void:
	duration.connect("timeout",self,"finish")
	
func _enter(params):
#	root.velocity += 1000*root.input_state.dir
	root.velocity = 1000*root.input_state.dir
	duration.start()
	done = false
func _physics_update(delta:float) -> void:
	if done:
		goto(on_finish_goto_state)
		return

func _exit() -> void:
	duration.stop()


func finish():
	done = true
	
