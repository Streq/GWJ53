extends Node

var original_text = ""

func _ready() -> void:
	yield(get_parent(),"ready")
	original_text = get_parent().text
	LocaleMenu.connect("locale_changed", self, "trigger")
	
	trigger()

func trigger():
	get_parent().text = tr(original_text)
