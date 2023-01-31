extends Area2D


signal nothing_overlaps
func _physics_process(delta: float) -> void:
	if !get_overlapping_bodies():
		emit_signal("nothing_overlaps")
