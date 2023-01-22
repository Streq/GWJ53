extends Node2D

onready var ship = owner.owner if ship == null else ship

func trigger():
	pass
func release():
	pass
	
func teleport():
	var player = Group.get_one("player")
	player.get_node("%ship_enter").enter_ship(ship)
#	ship.enter_pilot(player)

func _on_owned_by(new_ship) -> void:
	ship = new_ship
