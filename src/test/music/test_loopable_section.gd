extends Node
tool
signal loop_finished
signal finished

onready var intro: AudioStreamPlayer = $intro
onready var loop: AudioStreamPlayer = $loop
onready var end: AudioStreamPlayer = $end

export var continue_looping := true

export (float, -80, 24)var volume_db := 0.0 setget set_volume_db
export (float) var pitch_scale := 1.0 setget set_pitch_scale

enum MixTarget {
	STEREO, SURROUND, CENTER
}
export (MixTarget) var mix_target = MixTarget.STEREO setget set_mix_target


func set_mix_target(val: int):
	mix_target = val
	for child in get_children():
		child.mix_target = val

func set_volume_db(val: float):
	volume_db = val
	for child in get_children():
		child.volume_db = val


func set_pitch_scale(val: float):
	pitch_scale = val
	for child in get_children():
		child.pitch_scale = val

func play(at := 0.0):
	
	intro.play()
	yield(intro,"finished")
	
	while continue_looping:
		loop.play()
		yield(loop,"finished")
		emit_signal("loop_finished")
	
	end.play()
	yield(end,"finished")
	emit_signal("finished")
