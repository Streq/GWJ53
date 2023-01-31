extends CanvasLayer
signal pause
signal unpause

onready var palettes: Control = $palettes
onready var choose_your_palette: Control = $choose_your_palette

var index = 0



func _ready() -> void:
	#TODO FIX, HACER MENU INTRO APARTE
	#ESTO ESTA ACA PORQUE SI NO LOS SONIDOS NO SE INICIALIZAN
#	yield(get_tree(),"idle_frame")
	emit_signal("pause")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_right"):
		next_palette()
	elif event.is_action_pressed("ui_left"):
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
	emit_signal("unpause")
	self.set_process_input(false)
	choose_your_palette.hide()
