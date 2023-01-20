extends CanvasLayer
onready var quotes: Control = $quotes
onready var texture_rect: TextureRect = $TextureRect


func trigger(cause:String):
	show()
	quotes.show_quote(cause)
	get_tree().current_scene.connect("tree_exited",self,"hide")
	set_process_input(true)
func _ready() -> void:
	set_process_input(false)
	hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("START"):
		get_tree().reload_current_scene()
