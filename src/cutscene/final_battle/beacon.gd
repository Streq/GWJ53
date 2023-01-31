extends Position2D


signal seen

func _on_screen_entered() -> void:
	emit_signal("seen")
	queue_free()
