extends Control


var map := {}
func _ready() -> void:
	for child in get_children():
		map[child.name] = child

func show_quote(quote):
	for quote in get_children():
		quote.hide()
	if !quote in map.keys():
		quote = "default"
	map[quote].show()
