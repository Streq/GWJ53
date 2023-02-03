extends Area2D

onready var canvas_layer: CanvasLayer = $CanvasLayer

export var can_leave := false
export var got_components := false

var ended := false

export (String, FILE, "*.tscn") var RESTART_SCENE := "res://src/cutscene/intro.tscn"

func done():
	can_leave = true

func done_components():
	got_components = true

func _ready():
	canvas_layer.hide()
	
	
func _on_leave_world_area_body_entered(body: Node) -> void:
	if can_leave:
		end()
	else:
		go_back()
func end():
	if ended:
		return
	ended = true
	get_tree().change_scene("res://src/final_battle_intro.tscn")



func go_back():
	if got_components:
		Text.say("I can't leave the planet yet, I gotta get the flowers!!!!", 10.0)
	else:
		Text.say("Leaving the atmosphere without the full ship was a bad idea", 10.0)
	
	get_tree().call_group("checkpoint_radar","show")

func _on_leave_world_area_body_exited(body: Node) -> void:
	get_tree().call_group("checkpoint_radar","hide")
