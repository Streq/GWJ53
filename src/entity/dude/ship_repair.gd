extends Node2D
var ship = null
onready var ship_detect: Area2D = $ship_detect
onready var ship_healer: Node = $ship_healer


func get_ship():
	var ship_areas = ship_detect.get_overlapping_areas()
	if ship_areas:
		return ship_areas[0].owner

func repair_ship(new_ship):
	ship_healer.trigger(new_ship)

func stop_repair_ship():
	ship_healer.pilot_exited()

