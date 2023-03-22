extends Label
onready var palettes: Control = $"%palettes"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	yield(palettes,"ready")
	
	for child in palettes.get_children():
		var tex : Control = child
		tex.connect("visibility_changed",self,"visibility_changed", [tex])



func visibility_changed(palette):
	if palette.visible:
		text = palette.name
