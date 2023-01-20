extends Node2D
signal entered_ship()
signal exited_ship()

var pilot_seat = null
onready var ship_detect: Area2D = $ship_detect


func get_ship():
	var ship_areas = ship_detect.get_overlapping_areas()
	if ship_areas:
		return ship_areas[0].owner

func enter_ship(ship):
	owner.state_machine._change_state("idle")
	ship.enter_pilot(owner)
	pilot_seat = ship.pilot_seat
	pilot_seat.connect("pilot_off",self, "_on_exit_ship")
	emit_signal("entered_ship")


func _on_exit_ship(pilot):
	if pilot != owner:
		return
	pilot_seat.disconnect("pilot_off",self,"_on_exit_ship")
	emit_signal("exited_ship")
