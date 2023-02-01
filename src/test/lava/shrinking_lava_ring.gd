extends Node2D
onready var timer: Timer = $Timer
onready var shrink_toward: Node2D = $lava_area/lava_tiles/shrink_toward

func trigger():
	shrink_toward.shrink()
	timer.start()

func step():
	shrink_toward.shrink_step()
