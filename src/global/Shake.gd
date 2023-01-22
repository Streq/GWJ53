extends Node

signal shake(direction)

func shake(direction):
	emit_signal("shake",direction)
