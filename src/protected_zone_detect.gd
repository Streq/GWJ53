extends Area2D

func _ready() -> void:
	connect("area_entered",self,"area_entered")

func area_entered(area):
	Text.say("The energy from this place seems protective", 5.0)
	queue_free()
