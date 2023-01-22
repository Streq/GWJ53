extends Label


func _process(delta: float) -> void:
	visible = !owner.is_holding_pickup() and owner.has_pickup_near()
