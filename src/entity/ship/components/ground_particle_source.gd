extends Position2D

onready var cooldown: Timer = $cooldown

func trigger():
	if cooldown.is_stopped():
		var particle = ParticlePool.play("ground_friction", global_position)
		particle.global_rotation = Vector2(owner.facing_dir, 0.0).angle()
		cooldown.start()
