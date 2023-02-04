extends Node


var current = null

var songs := {}

func _ready():
	
	for song in $songs.get_children():
		songs[song.name] = song


func play(name):
	if current:
		if current.playing and current.name == name:
			return current
		current.stop()
	current = songs[name]
	current.play()
	return current
func stop():
	if current:
		current.stop()
