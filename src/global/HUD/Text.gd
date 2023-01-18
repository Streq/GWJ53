extends CanvasLayer

onready var label: Label = $Label

func say(text):
	label.text = text
func add(text):
	label.text += "\n\n" + text
func clear():
	label.text = ""
