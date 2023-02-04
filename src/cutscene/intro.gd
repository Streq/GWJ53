extends CanvasLayer

signal player_pressed_next()

export (String, FILE, "*.tscn") var scene_on_finish 

var current_scene_index = 0
var current_scene = null
onready var scenes = $scenes.get_children()
onready var continue_label: Control = $continue



func _ready() -> void:
	Music.stop()
	if SessionState.skip_intro:
		get_tree().change_scene(scene_on_finish)
		return
	
	PauseMenu.enabled = false
	
	for scene in scenes:
		scene.connect("step_finished",self,"next")
		scene.hide()
	current_scene = scenes[current_scene_index]
	current_scene.trigger()

func next():
	if current_scene.is_finished:
		get_tree().change_scene(scene_on_finish)
		return
	continue_label.display()
	yield(self,"player_pressed_next")
	continue_label.hide()
	
	if !current_scene.is_finished:
		current_scene.next_step()
		return
	current_scene.hide()
	current_scene_index += 1
	if current_scene_index >= scenes.size():
		return
	current_scene = scenes[current_scene_index]
	current_scene.trigger()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("A") or (event.is_action_pressed("B") and SessionState.can_skip_text):
		emit_signal("player_pressed_next")
