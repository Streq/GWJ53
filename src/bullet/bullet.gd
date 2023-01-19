extends KinematicBody2D
signal hit()
signal collision(collision)

export var damage := 1.0
export var velocity := Vector2()

func _physics_process(delta: float) -> void:
	global_rotation_degrees = stepify(global_rotation_degrees,45.0)
	var collision = move_and_collide(velocity*delta)
	if collision:
		emit_signal("collision", collision)
		emit_signal("hit")
		collision.collider.terrain_get_hit(self, collision)
		queue_free()
	
