extends Node2D
signal full_perimeter

signal seen_beacon

var seen_beacons = 0
var total_beacons = 0


func _ready() -> void:
	var children = get_children()
	total_beacons = children.size()
	for child in children:
		child.connect("seen",self,"beacon_seen")


func beacon_seen():
	seen_beacons += 1
	emit_signal("seen_beacon")
	if total_beacons == seen_beacons:
		emit_signal("full_perimeter")
	
