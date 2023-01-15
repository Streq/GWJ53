extends Area2D



func _on_water_area_body_entered(body: Node) -> void:
	body.in_water = true


func _on_water_area_body_exited(body: Node) -> void:
	body.in_water = false
