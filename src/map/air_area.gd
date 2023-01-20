extends Area2D


export var oxygen_repletion_rate := 10.0

func _on_area_body_entered(body: Node) -> void:
	body.in_air = true

func _on_area_body_exited(body: Node) -> void:
	body.in_air = false
