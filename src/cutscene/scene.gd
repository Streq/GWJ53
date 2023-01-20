extends CanvasLayer
signal trigger
signal finished

func trigger():
	show()
	emit_signal("trigger")
func finish():
	emit_signal("finished")
