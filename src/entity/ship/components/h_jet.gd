extends Node2D

export var power := 100.0

onready var animation_player: AnimationPlayer = $AnimationPlayer

export onready var firing := false setget set_firing  
onready var exit: Node2D = $exit

func set_firing(val):
	firing = val
	if firing:
		animation_player.play("fire")
	else:
		animation_player.play("idle")

func start():
	set_firing(true)

func stop():
	set_firing(false)



func _physics_process(delta: float) -> void:
	if firing:
		owner.velocity += exit.global_position.direction_to(global_position)*power*delta
