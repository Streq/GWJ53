extends Node2D

export var lifetime := 1.0 setget set_lifetime

onready var blue_particles: CPUParticles2D = $blue_particles
onready var red_particles: CPUParticles2D = $red_particles
onready var timer: Timer = $Timer
var triggered := false

func set_lifetime(val):
	lifetime = val
	if !is_inside_tree():
		return
	blue_particles.lifetime = lifetime
	red_particles.lifetime = lifetime

func trigger():
	if triggered:
		return
	triggered = true
	blue_particles.emitting = true
	red_particles.emitting = true
	NodeUtils.reparent_keep_transform(self, owner.get_parent())
	timer.start(lifetime*2.0)

func initialize_from_collision(collision:KinematicCollision2D):
	global_rotation = -collision.normal.angle()
	

func _ready() -> void:
	set_lifetime(lifetime)
