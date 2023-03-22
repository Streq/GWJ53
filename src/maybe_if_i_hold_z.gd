extends Area2D

onready var timer: Timer = $Timer
onready var player_got_past: Area2D = $player_got_past
export var text_to_say := "MAYBE_HOLD_Z"

func _ready() -> void:
	connect("body_entered",self,"body_entered")
	connect("body_exited",self,"body_exited")
	timer.start()
	timer.paused = true
	timer.connect("timeout",self,"timeout")
	player_got_past.connect("body_entered",self,"player_got_past")
func body_entered(body):
	timer.paused = false

func body_exited(body):
	timer.paused = true

func timeout():
	Text.say(text_to_say)
func player_got_past(body):
	Text.say("")
	queue_free()
