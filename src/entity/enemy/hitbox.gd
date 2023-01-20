extends Area2D

signal hit()

export var damage := 1.0
export var knockback := Vector2()
export var multiple_hit_per_frame := false

var hit_something_already := false


func _on_hitbox_area_entered(area: Area2D) -> void:
	if !multiple_hit_per_frame and hit_something_already:
		return
	if area.get_team() != owner.team:
		area.get_hurt(self)

func register_hit():
	emit_signal("hit")
	hit_something_already = true

func _physics_process(delta: float) -> void:
	for area in get_overlapping_areas():
		_on_hitbox_area_entered(area)
	hit_something_already = false
