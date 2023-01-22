extends VBoxContainer

var map = {}

func _ready():
	for component in get_children():
		map[component.type] = component

func observe_ship(ship):
	var slots = ship.get_node("%slots")
	for key in map.keys():
		var slot = slots.map[key]
		var component_indicator = map[key]
		slot.connect("coupled",component_indicator,"done")
		slot.connect("decoupled",component_indicator,"todo")
