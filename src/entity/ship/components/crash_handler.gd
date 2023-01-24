extends Node

onready var hurtbox: Area2D = $"%hurtbox"
onready var invulnerability_window: Timer = $invulnerability_window

var invulnerable := false

func crash(previous_velocity:Vector2):
	if invulnerable:
		return
	invulnerable = true
	var particles : CPUParticles2D = ParticlePool.play("ship_crash", owner.global_position)
	particles.direction = previous_velocity.normalized()
	particles.initial_velocity = previous_velocity.length()*0.7
	hurtbox.take_damage(1.0)
	Shake.shake(previous_velocity.normalized()*2.0)
	invulnerability_window.start()
	yield(invulnerability_window,"timeout")
	invulnerable = false
