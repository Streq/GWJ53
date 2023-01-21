extends Control
onready var blink: AnimationPlayer = $continue/blink

func display():
	show()
	blink.play("RESET")
	blink.advance(0.0)
	blink.play("blink")
