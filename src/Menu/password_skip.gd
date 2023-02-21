extends Node
onready var timer: Timer = $timer

export var skip_text = "BOSSMAN"
var buffer = ""

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		var key : InputEventKey = event
		var scancode = key.scancode
		if KEY_A <= scancode and KEY_Z >= scancode:
			buffer += OS.get_scancode_string(scancode)
			timer.start()
			if buffer == skip_text:
				MenuStack.clear()
				get_tree().change_scene("res://src/final_battle_intro.tscn")

func _ready() -> void:
	timer.connect("timeout",self,"clear")
	exit()

func clear():
	buffer = ""


func enter():
	set_process_input(true)
func exit():
	set_process_input(false)
