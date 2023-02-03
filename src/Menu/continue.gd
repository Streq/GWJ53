extends Node


func trigger():
	MenuStack.pop()
	SessionState._load()
	get_tree().change_scene("res://src/cutscene/intro.tscn")
