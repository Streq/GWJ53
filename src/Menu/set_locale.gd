extends Node

export var locale := "es"

func _ready() -> void:
	get_parent().connect("focused",self,"trigger")

func trigger():
	LocaleMenu.set_locale(locale)
