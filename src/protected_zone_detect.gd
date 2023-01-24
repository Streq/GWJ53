extends Area2D
onready var time_since_said: Timer = $time_since_said

var enabled := false

func _ready() -> void:
	connect("area_entered",self,"area_entered")
	connect("area_exited",self,"area_exited")

func area_entered(area):
	if enabled:
		Text.say("The energy from this place seems protective", 5.0)
		enabled = false
		yield(time_since_said,"timeout")
		enabled = true
func area_exited(area):
	time_since_said.start()
	
