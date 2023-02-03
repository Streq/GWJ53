extends CanvasLayer
onready var options: VBoxContainer = $"%options"
onready var background: CanvasLayer = $"%background"
	

func enter():
	if SessionState.has_save():
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
	exit()
