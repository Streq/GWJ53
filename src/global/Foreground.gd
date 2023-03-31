extends CanvasLayer
signal pause
signal unpause

signal enter
signal exit

onready var palettes: Control = $palettes
onready var choose_your_palette: Control = $choose_your_palette

var index = 0

var palette = null

signal palette_updated(name)

func _ready() -> void:
	exit()
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_right"):
		next_palette()
	elif event.is_action_pressed("ui_left"):
		prev_palette()
	elif event.is_action_pressed("A"):
		palette_selected()
		get_tree().set_input_as_handled()
	

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
	palette = pals[index]
	palette.show()
	emit_signal("palette_updated", palette.name)
	
func palette_selected():
	yield(get_tree(),"idle_frame")
	MenuStack.pop()


func enter():
	emit_signal("enter")
	self.set_process_input(true)
	choose_your_palette.show()
	emit_signal("pause")

func exit():
	self.set_process_input(false)
	choose_your_palette.hide()
	emit_signal("unpause")
	emit_signal("exit")
