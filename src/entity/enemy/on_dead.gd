extends Node

func _ready() -> void:
	get_parent().owner.connect("dead",self,"trigger")

func trigger():
	ParticlePool.play("enemy_dead", get_parent().owner.global_position)
