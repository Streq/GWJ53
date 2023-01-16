extends State
class_name CharacterState

export var animation := ""
export var on_finish_goto_state := ""

func enter(params):
	root.animation_player.play("RESET")
	root.animation_player.advance(0.0)
	root.animation_player.play(animation)
	root.animation_player.connect("animation_finished", self, "_on_animation_finished")
	.enter(params)

func exit():
	root.animation_player.disconnect("animation_finished", self, "_on_animation_finished")
	.exit()


func _on_animation_finished(name):
	if on_finish_goto_state:
		goto(on_finish_goto_state)
