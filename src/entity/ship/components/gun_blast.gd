extends Sprite

func trigger():
	show()
	yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")
	hide()

