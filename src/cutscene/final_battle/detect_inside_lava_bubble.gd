extends Node2D

signal outside

func _physics_process(delta: float) -> void:
	for child in get_children():
		var ray : RayCast2D = child
		
		if !ray.is_colliding():
			emit_signal("outside")

			return
		
