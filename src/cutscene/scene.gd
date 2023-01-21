extends Control
signal trigger
signal step_finished
signal next_step
var is_finished = false

func trigger():
	show()
	emit_signal("trigger")

func next_step():
	emit_signal("next_step")

func finish_step():
	emit_signal("step_finished")

func finish():
	is_finished = true
	emit_signal("step_finished")
