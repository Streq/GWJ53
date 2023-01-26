extends CanvasLayer
onready var options: VBoxContainer = $"%options"

var active := false setget set_active
onready var pause_client: Node = $pause_client

func set_active(val):
	if active == val:
		return
	active = val
	if active:
		on()
	else:
		off()

func on():
	pause_client.pause()
	show()
	options.get_child(0).grab_focus()
	

func off():
	pause_client.unpause()
	hide()

func _ready() -> void:
	on()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("START"):
		self.active = !active
