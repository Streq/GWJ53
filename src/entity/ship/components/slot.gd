extends Node2D

signal trigger()
signal release()

func trigger():
	emit_signal("trigger")
func release():
	emit_signal("release")
