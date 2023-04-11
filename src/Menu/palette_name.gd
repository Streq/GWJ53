extends Label


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Foreground.connect("palette_updated",self,"update_palette")
	update_palette("Default")

func update_palette(name):
	text = name
