extends CanvasLayer

signal player_pressed_next()

var current_scene = 0
onready var scenes = $scenes.get_children()
onready var continue_label: Label = $continue

func _ready() -> void:
	for scene in scenes:
		scene.connect("finished",self,"next")
		scene.hide()
	scenes[current_scene].trigger()
func next():
	continue_label.show()
	yield(self,"player_pressed_next")
	continue_label.hide()
	scenes[current_scene].hide()
	current_scene += 1
	if current_scene >= scenes.size():
		return
	scenes[current_scene].trigger()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("A"):
		emit_signal("player_pressed_next")
