extends Node

func trigger(pos):
	ParticlePool.play("terrain_destroyed_bot_left",pos)
	ParticlePool.play("terrain_destroyed_bot_right",pos)
	ParticlePool.play("terrain_destroyed_top_left",pos)
	ParticlePool.play("terrain_destroyed_top_right",pos)
	
	ParticlePool.play("terrain_destroyed_particles",pos)
	
	SFX.play("terrain_destroyed", pos)
