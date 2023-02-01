extends Node2D
tool

export var sfx := ""
export var play := false setget set_play

func play():
	SFX.play(sfx, global_position)

func set_play(val):
	if val:
		play()
