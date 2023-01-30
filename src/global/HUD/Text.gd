extends CanvasLayer

signal finished()
signal player_pressed_A()

signal done_with_current_text()

onready var label: Label = $Label
onready var continue_label: Control = $continue

export var skip_on_debug := false

var queue = []
var latest_stamp = 0

var current_animating_label : Label = null

onready var timer: Timer = $Timer

func _ready() -> void:
	timer.connect("timeout",self,"done_with_current_text")

func say(text, time := -1.0):
	latest_stamp += 1
	done_with_current_text()
	
	label.text = text
	label.visible_characters = -1
	var current_stamp = latest_stamp
	
	current_animating_label = label
	if time>0.0:
		timer.start(time)
		yield(self, "done_with_current_text")
		if latest_stamp == current_stamp:
			label.text = ""
		current_animating_label = null
#	label.trigger()

func add(text):
	label.text += "\n\n" + text

func clear():
	label.text = ""


func say_and_wait_for_input(text):
	#FOR DEBUG
	if skip_on_debug and OS.is_debug_build():
		print(text)
		yield(get_tree(),"idle_frame")
		emit_signal("finished")
		return
	#FOR DEBUG
	
	if queue:
		queue.append(text)
		return
	
	queue.append(text)
	Pause.pause(Pause.Level.TEXT)
	
	while !queue.empty():
		latest_stamp += 1
		var next_text = queue.front()
		label.text = next_text
		label.trigger()
		current_animating_label = label
		yield(label,"finished")
		current_animating_label = null
		continue_label.display()
		yield(self, "player_pressed_A")
		continue_label.hide()
		queue.pop_front()
	
	label.text = ""
	emit_signal("finished")
	unpause()

func say_array(texts):
	for text in texts:
		say_and_wait_for_input(text)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("A"):
		emit_signal("player_pressed_A")
	if event.is_action_pressed("B") and OS.is_debug_build():
		return
		emit_signal("player_pressed_A")
		skip()
#	if event.is_action_pressed("R"):
#		pause_mode = PAUSE_MODE_INHERIT
#		yield(get_tree().create_timer(1.0),"timeout")
#		pause_mode = PAUSE_MODE_PROCESS
#	if event.is_action_pressed("L"):
#		pause_mode = PAUSE_MODE_PROCESS
	
	
func skip():
	if current_animating_label:
		current_animating_label.force_finish()
	
func unpause():
	for i in 2: #prevent jump after dialog end
		yield(get_tree(),"physics_frame")
	Pause.unpause(Pause.Level.TEXT)

func done_with_current_text():
	emit_signal("done_with_current_text")
