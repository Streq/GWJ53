extends Node


func _ready() -> void:
	owner.connect("dead",self,"player_died")


func player_died():
	SessionState.deaths += 1
