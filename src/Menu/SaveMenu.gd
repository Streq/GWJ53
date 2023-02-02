extends CanvasLayer
onready var options: VBoxContainer = $"%options"
onready var background: CanvasLayer = $"%background"
	

func on():
	show()
	background.show()
	options.get_child(0).grab_focus()

func _ready() -> void:
	if SessionState.has_save():
		on()
	else:
		get_tree().change_scene("res://src/cutscene/intro.tscn")
