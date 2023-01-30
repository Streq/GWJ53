extends CharacterState
onready var duration: Timer = $duration
signal done()
var done = false

export var toward_velocity := -3.0

func _ready() -> void:
	duration.connect("timeout",self,"finish")
	
func _enter(params):
	root.velocity = Vector2()
	duration.start()
	done = false
	
var previous_velocity := Vector2()
func _physics_update(delta:float) -> void:
	if done:
		emit_signal("done")
		goto(on_finish_goto_state)
		return
	
	root.velocity += root.input_state.dir*root.speed*toward_velocity*delta
	
func _exit() -> void:
	duration.stop()


func finish():
	done = true
	
