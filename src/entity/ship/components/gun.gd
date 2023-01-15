extends Node2D


export onready var firing := false setget set_firing  
onready var exit: Node2D = $exit

func set_firing(val):
	firing = val

func start():
	set_firing(true)

func stop():
	set_firing(false)



