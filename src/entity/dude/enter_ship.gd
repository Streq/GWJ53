extends Node2D
onready var ship_detect: Area2D = $ship_detect


func get_ship():
	var ship_areas = ship_detect.get_overlapping_areas()
	if ship_areas:
		return ship_areas[0].owner

func enter_ship(ship):
	owner.state_machine._change_state("idle")
	ship.enter_pilot(owner)
