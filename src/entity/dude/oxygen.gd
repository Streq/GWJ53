extends Node
signal drown
signal not_full
signal full
onready var bar: Node = $bar

onready var breathe_obstructor_detect: Area2D = $"../breathe_obstructor_detect"
onready var breathe_air_detect: Area2D = $"../breathe_air_detect"



func _physics_process(delta: float) -> void:
	if !bar.value:
		emit_signal("drown")
		return
	var air_pockets = breathe_air_detect.get_overlapping_areas()
	
	var obstructors = breathe_obstructor_detect.get_overlapping_areas()
	if obstructors:
		var obstructor = obstructors[0]
		bar.value -= delta
	elif air_pockets:
		for air_pocket in air_pockets:
			bar.value += delta * air_pocket.oxygen_repletion_rate
	else:
		bar.value -= delta*5.0
	
	if bar.value != bar.max_value:
		emit_signal("not_full")
	
func fill(amount):
	bar.value+=amount
