extends Node2D


signal collected()

onready var panel: Sprite = $panel
var collected = false
func collect():
	if collected:
		return
	collected = true
	emit_signal("collected")
	SFX.play("bio_sample",global_position)
	queue_free()

func _on_Area2D_body_entered(body: Node) -> void:
	collect()
func make_important():
	panel.show()
	
