extends Area2D
signal hurt()
onready var health: Node = $"%health"

func get_hurt(hitbox):
	health.take_damage(hitbox.damage)
	emit_signal("hurt")
