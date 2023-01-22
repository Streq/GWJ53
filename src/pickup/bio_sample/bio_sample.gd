extends Node2D


signal collected()



func _on_Area2D_body_entered(body: Node) -> void:
	emit_signal("collected")
	queue_free()
