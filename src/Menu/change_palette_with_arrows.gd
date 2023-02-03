extends Node



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().connect("entered",self,"activate")
	get_parent().connect("exited",self,"deactivate")
	deactivate()


func activate():
	set_process_unhandled_input(true)
	
func deactivate():
	set_process_unhandled_input(false)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left"):
		Foreground.prev_palette()
	if event.is_action_pressed("ui_right"):
		Foreground.next_palette()
