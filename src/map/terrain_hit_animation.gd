extends Node


onready var top_right: CPUParticles2D = $"../terrain_destroyed_top_right"
onready var bot_right: CPUParticles2D = $"../terrain_destroyed_bot_right"
onready var bot_left: CPUParticles2D = $"../terrain_destroyed_bot_left"
onready var top_left: CPUParticles2D = $"../terrain_destroyed_top_left"
onready var particles: CPUParticles2D = $"../terrain_destroyed_particles"


func trigger(pos):
	bot_left.play_at(pos)
	bot_right.play_at(pos)
	top_left.play_at(pos)
	top_right.play_at(pos)
	
	particles.play_at(pos)
	SFX.play("terrain_destroyed", pos)
