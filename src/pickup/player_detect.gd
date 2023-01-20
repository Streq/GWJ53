extends Area2D
onready var label: Label = $"%Label"


func _process(delta: float) -> void:
	label.visible = !owner.grabbed and !get_overlapping_areas().empty()
