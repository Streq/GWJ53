extends CanvasLayer
onready var options: VBoxContainer = $"%options"
onready var background: CanvasLayer = $"%background"
signal entered()
signal exited()

var enabled := false setget set_enabled

func set_enabled(val):
	enabled = val
	set_process_input(val)


func enter():
	pause()
	show()
	set_enabled(true)
	background.show()
	options.get_child(0).grab_focus()
	emit_signal("entered")

func exit():
	unpause()
	set_enabled(false)
	background.hide()
	hide()
	emit_signal("exited")

func _ready() -> void:
	exit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("START"):
		get_tree().set_input_as_handled()
		MenuStack.pop()

func pause():
	Pause.pause(PauseState.Level.MENU)
func unpause():
	Pause.unpause(PauseState.Level.MENU)
