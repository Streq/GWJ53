extends Node

signal is_splash()
onready var water_splash: AudioStreamPlayer2D = $"%water_splash_sound"

func decide():
	var range_lerped = clamp(range_lerp(owner.velocity.length(),10,100,0,100),0,100)
		
	water_splash.volume_db = range_lerp(range_lerped,0,100,-50,-18)
#	print(water_splash.volume_db)
	water_splash.play()
