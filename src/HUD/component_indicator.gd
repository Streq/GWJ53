extends Label
onready var animation_player: AnimationPlayer = $AnimationPlayer

signal done()
signal todo()

export var type := ""
export var additional_text := ""

onready var prefix = text

var done = false


func done():
	done = true
	animation_player.play("done")
	emit_signal("done")
	update_text()

func todo():
	done = false
	animation_player.play("todo")
	emit_signal("todo")
	update_text()

func _ready() -> void:
	update_text()
	LocaleMenu.connect("locale_changed",self,"update_text")


func update_text():
	if done:
		text = tr(prefix) + " - " + tr(additional_text)
	else:
		print(prefix)
		text = tr(prefix)


