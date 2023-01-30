extends Node2D


export var enabled := true setget set_enabled
export var gravity := 200.0
export var damping := 1.0

func set_enabled(val):
	enabled = val
	set_physics_process(enabled)
func _ready() -> void:
	set_enabled(enabled)

func _physics_process(delta: float) -> void:
	pull_player(delta)
	pull_ship(delta)
	

func pull_player(delta):
	var player = Group.get_one("player")
	if is_instance_valid(player):
		pull(player, delta)

func pull(entity, delta):
	entity.velocity -= global_position.direction_to(entity.global_position)*gravity*delta
	entity.velocity *= 1.0-delta*damping
func pull_ship(delta):
	var ship = Group.get_one("ship")
	if is_instance_valid(ship):
		pull(ship, delta)
