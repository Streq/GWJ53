extends Node2D
signal restart()
func restart():
	get_tree().call_group("pickup","respawn")
	get_tree().call_group("respawn_on_restart","respawn")
	get_tree().call_group("eye","queue_free")
	emit_signal("restart")

func _ready() -> void:
	PauseMenu.enabled = true
