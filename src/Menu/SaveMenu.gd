extends CanvasLayer
onready var options: VBoxContainer = $"%options"
onready var background: CanvasLayer = $"%background"
	

func enter():
	show()
	background.show()
	options.get_child(0).grab_focus()

func exit():
	hide()
	background.hide()

func _ready() -> void:
	if SessionState.has_save():
		MenuStack.push(self)
	else:
		get_tree().change_scene("res://src/cutscene/intro.tscn")
	
