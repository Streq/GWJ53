extends Node2D

export var pool_size := 10
export var SOUND : PackedScene
export var audio : AudioStream



var index = 0
export var cooldown := 0.0833335
var seconds_since_last_call = 1000.0
func _ready() -> void:
	for i in pool_size:
		var sound = SOUND.instance()
		sound.stream = audio
		add_child(sound)
		


func play(play_global_position):
	if seconds_since_last_call<cooldown:
		return
	seconds_since_last_call = 0.0
	var sound : AudioStreamPlayer2D = get_child(index)
	sound.global_position = play_global_position
	sound.play()
	index = (index+1)%pool_size

func _physics_process(delta: float) -> void:
	seconds_since_last_call+=delta
