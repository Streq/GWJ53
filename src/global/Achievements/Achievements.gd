extends Node

signal changed()

signal complete(achievement)

var map = {}
onready var list: Node = $"%list"



func _ready() -> void:
	for achievement in list.get_children():
		map[achievement.name] = achievement
	
	
func complete(achievement_name):
	if map.has(achievement_name):
		var achievement : Achievement = map[achievement_name]
		achievement.completed = true
		
		emit_signal("complete",achievement_name)
		print("Achievement \"%s\" unlocked" % achievement.title)
		emit_signal("changed")
func is_complete(achievement_name):
	if map.has(achievement_name):
		var achievement : Achievement = map[achievement_name]
		return achievement.completed
	return false

func clear():
	for achievement in map.values():
		achievement.completed = false
	emit_signal("changed")
