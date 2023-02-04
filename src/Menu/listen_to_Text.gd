extends Node


func _ready() -> void:
#	Text.connect("display_text", owner, "add_text")
	
	Text.connect("display_label", owner, "add_label")
