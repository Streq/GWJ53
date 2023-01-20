extends Node
signal drown
signal not_full
signal full
onready var bar: Node = $bar

onready var breathe_obstructor_detect: Area2D = $"../breathe_obstructor_detect"
onready var breathe_air_detect: Area2D = $"../breathe_air_detect"

const GRACE_FRAMES = 2

#this variable is to ensure the oxygen bar doesn't show on teleport, 
#given teleportation for some reason makes the player stop colliding with air for a single frame
var frames_since_oxygen = 0

func _physics_process(delta: float) -> void:
	if !bar.value:
		emit_signal("drown")
		return
	var air_pockets = breathe_air_detect.get_overlapping_areas()
	
	
	var obstructors = breathe_obstructor_detect.get_overlapping_areas()
	if obstructors:
		frames_since_oxygen += 1
		if frames_since_oxygen > GRACE_FRAMES:
			var obstructor = obstructors[0]
			bar.value -= delta
	elif air_pockets:
		for air_pocket in air_pockets:
			if bar.value != bar.max_value:
				bar.value += delta * air_pocket.oxygen_repletion_rate
		frames_since_oxygen = 0
	else:
		frames_since_oxygen += 1
		if frames_since_oxygen > GRACE_FRAMES:
			bar.value -= delta*5.0
	
	if bar.value != bar.max_value:
		emit_signal("not_full")
	
func fill(amount):
	bar.value+=amount
	frames_since_oxygen = 0
