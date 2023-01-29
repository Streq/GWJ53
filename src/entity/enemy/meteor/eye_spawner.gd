extends Node2D

signal spawned()
signal stop()
export var MOB : PackedScene
onready var point_source = $"%point_source"
export var trigger := false

func _ready() -> void:
	if trigger:
		call_deferred("spawn")
func spawn():
#	var point = point_source.get_point()
	var points = point_source.get_points()
	for point in points:
		var spawn_position = point
		
		var mob = MOB.instance()
		get_tree().current_scene.add_child(mob)
		mob.global_position = spawn_position
		
	emit_signal("spawned")

func stop():
	emit_signal("stop")
