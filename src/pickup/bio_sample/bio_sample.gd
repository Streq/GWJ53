extends Node2D


signal collected()

onready var panel: Sprite = $panel


func _on_Area2D_body_entered(body: Node) -> void:
	emit_signal("collected")
	SFX.play("bio_sample",global_position)
	queue_free()

func make_important():
	panel.show()
