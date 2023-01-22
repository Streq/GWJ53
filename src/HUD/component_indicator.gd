extends Label
onready var animation_player: AnimationPlayer = $AnimationPlayer

signal done()
signal todo()

export var type := ""


func done():
	animation_player.play("done")
	emit_signal("done")

func todo():
	animation_player.play("todo")
	emit_signal("todo")
