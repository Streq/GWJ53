extends Sprite


func _process(delta: float) -> void:
	position = global_position.direction_to(Group.get_one("player").global_position)
	
