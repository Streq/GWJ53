extends CanvasLayer
onready var options: VBoxContainer = $"%options"
onready var background: CanvasLayer = $"%background"

var active := false setget set_active
var enabled := false setget set_enabled

func set_enabled(val):
	enabled = val
	set_process_input(val)
	
onready var pause_client: Node = $pause_client

func set_active(val):
	if active == val:
		return
	if val:
		on()
	else:
		off()

func on():
	pause()
	show()
	background.show()
	options.get_child(0).grab_focus()
	

func off():
	unpause()
	background.hide()
	hide()

func _ready() -> void:
	off()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("START"):
		self.active = !active

func pause():
	active = true
	Pause.pause(PauseState.Level.MENU)
func unpause():
	active = false
	Pause.unpause(PauseState.Level.MENU)
