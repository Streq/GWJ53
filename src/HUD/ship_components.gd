extends VBoxContainer
signal ship_complete()

var map = {}

var total_components = 0
var current_components = 0
func _ready():
	for component in get_children():
		map[component.type] = component
	total_components = map.size()

func observe_ship(ship):
	var slots = ship.get_node("%slots")
	for key in map.keys():
		var slot = slots.map[key]
		var component_indicator = map[key]
		slot.connect("coupled",component_indicator,"done")
		slot.connect("coupled",self,"component_done")
		slot.connect("decoupled",component_indicator,"todo")

func component_done():
	current_components += 1
	if current_components == total_components:
		emit_signal("ship_complete")
