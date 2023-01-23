extends CanvasLayer
onready var bio_sample: AudioStreamPlayer2D = $Control/bio_sample

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("A"):
		trigger()

func trigger():
	bio_sample.play_at_position(bio_sample.global_position)
