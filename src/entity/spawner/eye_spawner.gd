extends Node2D

signal spawned()
signal stop()
export var MOB : PackedScene
onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
export var trigger := false

func _ready() -> void:
	if trigger:
		call_deferred("spawn")
func spawn():
	path_follow_2d.unit_offset = randf()
	var spawn_position = path_follow_2d.global_position
	
	var mob = MOB.instance()
	get_tree().current_scene.add_child(mob)
	mob.global_position = spawn_position
	
	emit_signal("spawned")

func stop():
	emit_signal("stop")
