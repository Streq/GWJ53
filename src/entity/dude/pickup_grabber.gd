extends Node2D

onready var pickup_hold: Node2D = $pickup_hold
onready var pickup_detect_area: Area2D = $pickup_detect_area
onready var ship_detect_area: Area2D = $ship_detect_area

var current = null

func _physics_process(delta: float) -> void:
	if owner.input_state.B.is_just_pressed():
		if is_holding_pickup():
			if has_ship_near():
				put_on_ship(get_ship())
			else:
				drop()
		else:
			attempt_grab()


func attempt_grab():
	var pickups = pickup_detect_area.get_overlapping_bodies()
	if pickups:
		grab(pickups[0])

func grab(pickup):
	NodeUtils.reparent(pickup, pickup_hold)
	pickup.position = Vector2()
	pickup.grabbed = true
	current = pickup


func drop():
	if is_instance_valid(current):
		NodeUtils.reparent_keep_transform(current, owner.get_parent())
		current.velocity = owner.velocity
		current.grabbed = false
		current = null
	
func is_holding_pickup():
	return is_instance_valid(current)
func has_ship_near():
	return !ship_detect_area.get_overlapping_areas().empty()
func get_ship():
	return ship_detect_area.get_overlapping_areas()[0].get_parent()
func put_on_ship(ship):
	current.connect_to_ship(ship)
