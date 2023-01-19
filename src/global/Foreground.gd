extends CanvasLayer
onready var palettes: Control = $palettes
onready var choose_your_palette: Control = $choose_your_palette

var index = 0

func _ready() -> void:
	get_tree().paused = true


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down"):
		index += 1
	elif event.is_action_pressed("ui_up"):
		index -= 1
	elif event.is_action_pressed("A"):
		palette_selected()
	var pals = palettes.get_children()
	index = posmod(index, palettes.get_child_count())
	for palette in pals:
		palette.hide()
	pals[index].show()
	

func palette_selected():
	get_tree().paused = false
	self.set_process_input(false)
	choose_your_palette.hide()
