extends Node2D

export var lifetime := 1.0 setget set_lifetime
export var sfx := "bullet_wall"

#onready var timer: Timer = $Timer
#var triggered := false

func set_lifetime(val):
	lifetime = val
	
func trigger():
	if sfx:
		SFX.play(sfx,global_position)
	
	var blue_particles :CPUParticles2D = ParticlePool.play("blue_particles",global_position)
	blue_particles.global_rotation = global_rotation
	blue_particles.lifetime = lifetime
	
	var red_particles :CPUParticles2D = ParticlePool.play("red_particles",global_position)
	red_particles.global_rotation = global_rotation
	red_particles.lifetime = lifetime
	

func initialize_from_collision(collision:KinematicCollision2D):
	global_rotation = -collision.normal.angle()
	

func _ready() -> void:
	set_lifetime(lifetime)
