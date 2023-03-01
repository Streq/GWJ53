extends TextureRect
onready var locked: TextureRect = $locked

var completed := false

func completed():
	completed = true
	if locked:
		locked.hide()

func _ready() -> void:
	if completed:
		completed()
	pass
