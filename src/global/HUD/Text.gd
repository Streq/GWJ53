extends CanvasLayer

signal finished()
signal player_pressed_A()

onready var label: Label = $Label
onready var continue_label: Control = $continue

export var skip_on_debug := false

var queue = []
var latest_stamp = 0

var current_animating_label : Label = null

func say(text, time := -1.0):
	label.text = text
	label.visible_characters = -1
	latest_stamp += 1
	var current_stamp = latest_stamp
	if time>0.0:
		yield(get_tree().create_timer(time),"timeout")
		if latest_stamp == current_stamp:
			label.text = ""
			
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
	get_tree().paused = true
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
	if event.is_action_pressed("B"):
		emit_signal("player_pressed_A")
		skip()
	
func skip():
	if current_animating_label:
		current_animating_label.force_finish()
	
func unpause():
	for i in 2: #prevent jump after dialog end
		yield(get_tree(),"physics_frame")
	get_tree().paused = false
