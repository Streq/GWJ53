extends Label
signal finished
onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func trigger():
	visible_characters = 0
	var tween = create_tween()
	tween.tween_method(
		self,
		"show_characters",
		0,
		get_total_character_count(),
		get_total_character_count()*0.05
	)
	yield(tween,"finished")
	emit_signal("finished")

func show_characters(count):
	if visible_characters != count:
		visible_characters = count
		audio_stream_player.play()
