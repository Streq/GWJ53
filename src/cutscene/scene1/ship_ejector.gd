extends Node

export var ship_path : NodePath
onready var ship = get_node(ship_path)

func trigger():
	var seat = ship.pilot_seat
	var pilot = seat.pilot
	
	seat.unseat_on_frame()
	pilot.queue_free()
