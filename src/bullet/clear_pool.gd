extends Node

onready var collision_shape_2d: CollisionShape2D = $"%CollisionShape2D"
onready var hitbox: Area2D = $"%hitbox"
onready var lifetime: Timer = $"%lifetime"
onready var hide_if_diagonal_orth: Node = $"../orthogonal/hide_if_diagonal"
onready var hide_if_diagonal_diag: Node = $"../diagonal/hide_if_diagonal"

func despawn():
	owner.hide()
	collision_shape_2d.disabled = true
	hitbox.monitoring = false
	lifetime.stop()
	var processing = false
	NodeUtils.pause(hitbox,processing)
	NodeUtils.pause(owner,processing)
	NodeUtils.pause(hide_if_diagonal_diag,processing)
	NodeUtils.pause(hide_if_diagonal_orth,processing)
	pass

func spawn():
	owner.show()
	collision_shape_2d.disabled = false
	hitbox.monitoring = true
	lifetime.start()
	var processing = true
	NodeUtils.pause(hitbox,processing)
	NodeUtils.pause(owner,processing)
	NodeUtils.pause(hide_if_diagonal_diag,processing)
	NodeUtils.pause(hide_if_diagonal_orth,processing)
	pass
