extends CharacterState


func _ready() -> void:
	pass
func _enter(params):
	pass
	root.velocity = Vector2()
func _exit():
	pass
func _physics_update(delta: float) -> void:
	pass


func _on_animation_finished(name):
	root.queue_free()
	pass
