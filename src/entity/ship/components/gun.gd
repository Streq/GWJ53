extends Node2D
signal fire()

export var BULLET : PackedScene
export var firing := false setget set_firing  
var shooting_muzzles = 0

onready var exit: Node2D = $exit


func set_firing(val):
	firing = val

func start():
	set_firing(true)

func stop():
	set_firing(false)

func _physics_process(delta: float) -> void:
	if firing:
		emit_signal("fire")
