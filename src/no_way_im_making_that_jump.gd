extends Area2D

onready var ship_detect: Area2D = $ship_detect

func _physics_process(delta: float) -> void:
	if get_overlapping_bodies():
		if ship_detect.get_overlapping_bodies().size()<=1:
			Text.say("No way I'm making this jump", 5.0)
			queue_free()
