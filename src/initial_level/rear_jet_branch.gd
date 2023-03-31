extends StaticBody2D


func _ready() -> void:
	if SessionState.has_repaired_ship:
		queue_free()
