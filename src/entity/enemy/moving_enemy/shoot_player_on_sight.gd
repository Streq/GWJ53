extends Node2D

onready var wearer = owner
var shooting_muzzles = 0
onready var muzzle: Node2D = $muzzle
onready var cooldown: Timer = $cooldown

export var cooldown_value := 5.0

export var predict_target_position := false
export var BULLET : PackedScene

func _ready():
	cooldown.wait_time = cooldown_value
	muzzle.BULLET = BULLET
func _physics_process(delta: float) -> void:
	var player = Group.get_one("player")
	if !is_instance_valid(player):
		return
		
	if can_see(player):
		aim(player)
		shoot()

func aim(target):
	var dest
	if predict_target_position:
		dest = Aiming.intercept(
			global_position, 
			target.global_position, 
			target.velocity, 
			muzzle.base_shoot_speed
		)
	if dest == null:
		dest = target.global_position
		
	var direction = global_position.direction_to(dest)
	
	
	muzzle.global_rotation = direction.angle()

func shoot():
	if !cooldown.is_stopped():
		return
	muzzle.shoot()
	cooldown.start()
	
	
func can_see(target):
	return true
