extends CanvasLayer
onready var palettes: Control = $palettes
onready var choose_your_palette: Control = $choose_your_palette

var index = 0



func _ready() -> void:
	Pause.pause(PauseState.Level.MENU)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down"):
		next_palette()
	elif event.is_action_pressed("ui_up"):
		prev_palette()
	elif event.is_action_pressed("A"):
		palette_selected()
	
	

func next_palette():
	index += 1
	update_palette()

func prev_palette():
	index -= 1
	update_palette()


func update_palette():
	index = posmod(index, palettes.get_child_count())
	var pals = palettes.get_children()
	for palette in pals:
		palette.hide()
	pals[index].show()
	
func palette_selected():
	Pause.pause(PauseState.Level.MENU)
	self.set_process_input(false)
	choose_your_palette.hide()
