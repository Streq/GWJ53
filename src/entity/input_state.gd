extends Node
class_name InputState

var A : ButtonState = ButtonState.new()
var B : ButtonState = ButtonState.new()
var L : ButtonState = ButtonState.new()
var R : ButtonState = ButtonState.new()
var dir := Vector2()


func _physics_process(delta: float) -> void:
	stale()
	
func stale():
	A.stale()
	B.stale()
	L.stale()
	R.stale()

func copy_from(input_state: InputState):
	A.copy_from(input_state.A)
	B.copy_from(input_state.B)
	L.copy_from(input_state.L)
	R.copy_from(input_state.R)
	dir = input_state.dir

