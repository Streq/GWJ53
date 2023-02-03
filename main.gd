extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	yield(get_tree(),"idle_frame")
	MenuStack.push(SaveMenu)
	MenuStack.push(Foreground)
	MenuStack.push(LocaleMenu)
	print(OS.get_user_data_dir())
