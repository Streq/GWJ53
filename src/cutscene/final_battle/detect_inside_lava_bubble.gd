extends Node2D

signal outside
onready var ship: KinematicBody2D = $"%ship"

onready var ship_seat := ship.get_node("%pilot_seat")

func _physics_process(delta: float) -> void:
	for child in get_children():
		var ray : RayCast2D = child
		
		if !ray.is_colliding() and ship_seat.pilot != null:
			emit_signal("outside")

			return
		
