extends KinematicBody2D
signal hit()
signal collision(collision)

export var damage := 1.0
export var velocity := Vector2()
export var team := -1

func _physics_process(delta: float) -> void:
	global_rotation_degrees = stepify(global_rotation_degrees,45.0)
	var collision = move_and_collide(velocity*delta)
	if collision:
		collision.collider.terrain_get_hit(self, collision)
		emit_signal("collision", collision)
		hit()


func hit():
	emit_signal("hit")
	queue_free()
	
