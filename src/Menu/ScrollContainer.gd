extends ScrollContainer

func _process(delta: float) -> void:
	scroll_vertical += Input.get_axis("ui_up","ui_down")*5
