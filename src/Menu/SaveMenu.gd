extends CanvasLayer
onready var options: VBoxContainer = $"%options"
onready var background: CanvasLayer = $"%background"

var has_save = false

func enter():
	if has_save:
		show()
		background.show()
		options.get_child(0).grab_focus()
	else:
		get_tree().change_scene("res://src/cutscene/intro.tscn")
		MenuStack.pop()

func exit():
	hide()
	background.hide()

func _ready() -> void:
	has_save = SessionState.has_save()
	exit()
