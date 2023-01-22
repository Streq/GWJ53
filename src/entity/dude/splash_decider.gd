extends Node

signal is_splash()
onready var water_splash: AudioStreamPlayer2D = $"%water_splash_sound"

func decide():
	if owner.velocity.y>10.0:
		water_splash.volume_db = range_lerp(owner.velocity.y,10,200,-48,-12)
		water_splash.play()
