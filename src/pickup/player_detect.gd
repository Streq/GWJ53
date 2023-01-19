extends Area2D
onready var label: Label = $"%Label"


func _physics_process(delta: float) -> void:
	label.visible = !get_overlapping_areas().empty()
