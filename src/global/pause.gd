extends Node
class_name PauseState

signal changed(state)

var state = 0

enum Level{
	WORLD,
	TEXT,
	MENU,
	COLOR_CHOOSE,
	GAME
}

func pause(level:=0):
	var flag = 1<<level
	state |= flag
	trim_state()
	emit_signal("changed", state)
	if !is_inside_tree():
		return
	get_tree().paused = state!=0

func unpause(level:=0):
	var flag = 1<<level
	state &= ~flag
	emit_signal("changed", state)
	
	if !is_inside_tree():
		return
	if !state:
		get_tree().paused = false
	get_tree().paused = state!=0
	
	
func trim_state():
	state &= (1<<Level.size())-1

