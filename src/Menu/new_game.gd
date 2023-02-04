extends Node


func trigger():
	MenuStack.pop()
	SessionState.clear()
	get_tree().change_scene("res://src/cutscene/intro.tscn")
