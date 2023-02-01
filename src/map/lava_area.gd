extends Area2D

signal hit()

export var damage := 100.0
export var knockback := Vector2()
export var multiple_hit_per_frame := false
export var hurt_alies = false

#var hit_something_already := false


func _on_hitbox_body_entered(body: Node2D) -> void:
	body.get_node("%hurtbox").take_damage(damage)

func register_hit():
	emit_signal("hit")

func _physics_process(delta: float) -> void:
	for body in get_overlapping_bodies():
		_on_hitbox_body_entered(body)
#	hit_something_already = false
