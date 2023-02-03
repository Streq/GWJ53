extends CanvasLayer
signal locale_changed()


onready var options: VBoxContainer = $"%options"
onready var background: CanvasLayer = $"%background"
	
var locale_to_option_index = {}


func enter():
	show()
	background.show()
	var selected_index = locale_to_option_index[TranslationServer.get_locale()]
	options.get_child(selected_index).grab_focus()
	set_process_input(true)
	Pause.pause(PauseState.Level.MENU)
	
func exit():
	hide()
	background.hide()
	set_process_input(false)
	Pause.unpause(PauseState.Level.MENU)
func _ready() -> void:
	var locales = Group.get_all("locale")
	var locale_option_index = 0
	for locale in locales:
		locale_to_option_index[locale.locale] = locale_option_index
		locale_option_index += 1 
		
	exit()
	pass

func set_locale(locale):
	TranslationServer.set_locale(locale)
	emit_signal("locale_changed")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("A"):
		get_tree().set_input_as_handled()
		MenuStack.pop()
