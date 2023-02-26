extends KinematicBody2D
signal hit()
signal despawn()
signal spawn()
signal collision(collision)
signal velocity_update()


export var damage := 1.0
export var velocity := Vector2() setget set_velocity
export var team := -1

func set_velocity(val):
	velocity = val
	global_rotation_degrees = stepify(rad2deg(val.angle()),45.0)
	emit_signal("velocity_update")

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity*delta)
	if collision:
		if collision.collider.has_method("terrain_get_hit"):
			collision.collider.terrain_get_hit(self, collision)
		emit_signal("collision", collision)
		hit()


func hit():
	emit_signal("hit")
	despawn()

func despawn():
	emit_signal("despawn")
	
func spawn():
	emit_signal("spawn")
