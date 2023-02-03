extends Node


func trigger():
	MenuStack.pop()
	get_tree().change_scene("res://src/cutscene/intro.tscn")
