extends Node

onready var collision_shape_2d: CollisionShape2D = $"%CollisionShape2D"
onready var hitbox: Area2D = $"%hitbox"
onready var lifetime: Timer = $"%lifetime"

func despawn():
	owner.hide()
	collision_shape_2d.disabled = true
	hitbox.monitoring = false
	lifetime.stop()
	hitbox.set_physics_process(false)
	owner.set_physics_process(false)
	owner.set_process(false)
	pass

func spawn():
	owner.show()
	collision_shape_2d.disabled = false
	hitbox.monitoring = true
	lifetime.start()
	hitbox.set_physics_process(true)
	owner.set_physics_process(true)
	owner.set_process(true)
	pass
