extends Node


export (PauseState.Level) var paused_at_level := PauseState.Level.WORLD
export (PauseState.Level) var pause_level := PauseState.Level.WORLD


func _ready() -> void:
	Pause.connect("changed",self,"_on_pause_changed")
	_on_pause_changed(Pause.state)

func _on_pause_changed(pause_state):
	if pause_state > (1<<paused_at_level):
		get_parent().pause_mode = PAUSE_MODE_INHERIT
	else:
		get_parent().pause_mode = PAUSE_MODE_PROCESS

func pause():
	Pause.pause(pause_level)
func unpause():
	Pause.unpause(pause_level)
