extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Text.clear_queue()
	Text.clear()
	Music.stop()
	MenuStack.clear()
	yield(get_tree(),"idle_frame")
	MenuStack.push_array([SaveMenu,Foreground,LocaleMenu])
