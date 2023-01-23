extends Area2D




func _on_protected_zone_body_entered(body: Node) -> void:
	body.get_node("%hurtbox").take_damage(100.0)
