extends Node


func trigger():
	SessionState._load()
	get_tree().change_scene("res://src/cutscene/intro.tscn")
