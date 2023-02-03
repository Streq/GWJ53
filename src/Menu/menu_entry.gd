extends Control
tool

signal selected()
signal focused()
signal lost_focus()

export var text := "entry" setget set_text
onready var left_arrow: Label = $"%left_arrow"
onready var right_arrow: Label = $"%right_arrow"

func set_text(val):
	text = val
	
	if is_inside_tree():
		$"%label".text = val

func _ready() -> void:
	set_text(text)
	_on_menu_entry_focus_exited()

func _on_menu_entry_focus_entered() -> void:
	left_arrow.modulate = Color.white
	right_arrow.modulate = Color.white
	emit_signal("focused")
func _on_menu_entry_focus_exited() -> void:
	left_arrow.modulate = Color.transparent
	right_arrow.modulate = Color.transparent
	emit_signal("lost_focus")
func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("A"):
		emit_signal("selected")
	
