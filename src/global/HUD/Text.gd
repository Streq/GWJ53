extends CanvasLayer


signal finished()
signal player_pressed_A()

signal done_with_current_text()
signal finished_loading()

signal display_text(text)

onready var continue_label: Control = $continue
onready var palette_client: Node = $"%palette_client"
onready var labels: Control = $"%labels"

export var skip_on_debug := false

export var skippable := false

var label_map = {}

const BASE_PALETTE = 9


var queue = []
var latest_stamp = 0

var label : Label = null

onready var timer: Timer = $Timer


func _ready() -> void:
	timer.connect("timeout",self,"done_with_current_text")
	for label in labels.get_children():
		label_map[label.name] = label

func say(text, time := -1.0, theme := "default"):
	latest_stamp += 1
	done_with_current_text()
	label = label_map[theme]
	label.text = tr(text)
	emit_signal("display_text",label.text)
	label.visible_characters = -1

	var current_stamp = latest_stamp
	
	if time>0.0:
		timer.start(time)
		yield(self, "done_with_current_text")
		if latest_stamp == current_stamp:
			label.text = ""
			emit_signal("finished")
			
#	label.trigger()

func clear():
	label.text = ""


func say_and_wait_for_input(request):
	#FOR DEBUG
	if skip_on_debug and OS.is_debug_build():
		print(request)
		yield(get_tree(),"idle_frame")
		emit_signal("finished")
		return
	#FOR DEBUG
	
	Pause.pause(Pause.Level.TEXT)
	if queue:
		queue.append(request)
		return
	if label:
		label.text = ""
	queue.append(request)
	
	while !queue.empty():
		latest_stamp += 1
		var next_request = queue.front()
		done_with_current_text()
		label = label_map[next_request.theme]
		label.text = tr(next_request.text)
		emit_signal("display_text",label.text)
		label.trigger()
		yield(label,"finished")
		emit_signal("finished_loading")
		continue_label.display()
		yield(self, "player_pressed_A")
		label.text = ""
		continue_label.hide()
		queue.pop_front()
	
	label.text = ""
	unpause()
#	emit_signal("finished")
	
func say_array(texts,theme := "default"):
	for text in texts:
		say_and_wait_for_input({"text":text,"theme":theme})

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("A"):
		emit_signal("player_pressed_A")
		if skippable:
			skip()
	if event.is_action_pressed("B") and (OS.is_debug_build() or SessionState.can_skip_text):
#		return
		emit_signal("player_pressed_A")
		skip()
#	if event.is_action_pressed("R"):
#		pause_mode = PAUSE_MODE_INHERIT
#		yield(get_tree().create_timer(1.0),"timeout")
#		pause_mode = PAUSE_MODE_PROCESS
#	if event.is_action_pressed("L"):
#		pause_mode = PAUSE_MODE_PROCESS
	
	
func skip():
	if label:
		label.force_finish()
	
func unpause():
	for i in 2: #prevent jump after dialog end
		yield(get_tree(),"physics_frame")
	if !label.text:
		Pause.unpause(Pause.Level.TEXT)
		emit_signal("finished")

func done_with_current_text():
	emit_signal("done_with_current_text")

