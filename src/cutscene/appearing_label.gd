extends Label
signal finished
onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
var tween : SceneTreeTween = null
func trigger():
	visible_characters = 0
	tween = create_tween()
	tween.tween_method(
		self,
		"show_characters",
		0,
		get_total_character_count(),
		get_total_character_count()*0.05
	)
	yield(tween,"finished")
	tween = null
	emit_signal("finished")

func force_finish():
	if is_done():
		return
	tween.custom_step(get_total_character_count()*0.05)

func is_done():
	return !is_instance_valid(tween)

func show_characters(count):
	if visible_characters != count:
		visible_characters = count
		audio_stream_player.play_at_position()
