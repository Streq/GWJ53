extends CanvasLayer
export var LOG_LABEL : PackedScene

onready var scroll_container: ScrollContainer = $ScrollContainer
onready var label_container: VBoxContainer = $"%label_container"

var enabled = false

func enter():
	pause()
	show()
	set_enabled(true)
	scroll_container.grab_focus()
	

func exit():
	unpause()
	set_enabled(false)
	hide()


#func add_text(text):
#	contents.text += text+"\n\n"
	

func add_label(label):
	var log_label = LOG_LABEL.instance()
	log_label.replicate(label)
	label_container.add_child(log_label)

func set_enabled(val):
	enabled = val
	set_process_input(val)
	yield(get_tree(),"idle_frame")
#	scroll_container.scroll_vertical = contents.rect_size.y
	scroll_container.scroll_vertical = scroll_container.get_v_scrollbar().max_value
	scroll_container.set_process(val)
	
func pause():
	Pause.pause(PauseState.Level.MENU)
func unpause():
	Pause.unpause(PauseState.Level.MENU)

func _ready():
	exit()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("A") or event.is_action_pressed("B"):
		get_tree().set_input_as_handled()
		MenuStack.pop()
		
