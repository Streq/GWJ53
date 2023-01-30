extends Node2D

onready var wearer = owner
var shooting_muzzles = 0

export var predict_target_position := false

export var shot_speed := 100.0

func _physics_process(delta: float) -> void:
	var player = Group.get_one("player")
	if !is_instance_valid(player):
		return
		
	if can_see(player):
		aim(player)
#		shoot()

func aim(target):
	var dest
	if predict_target_position:
		dest = Aiming.intercept(
			global_position, 
			target.global_position, 
			target.velocity, 
			shot_speed
		)
	if dest == null:
		dest = target.global_position
		
	var direction = global_position.direction_to(dest)
	
	
	global_rotation = direction.angle()

func can_see(target):
	return true
