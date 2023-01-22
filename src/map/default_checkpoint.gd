extends Node

onready var dude: KinematicBody2D = $"%dude"
onready var ship: KinematicBody2D = $"%ship"

const ACTIVE_CHECKPOINT = "active_checkpoint"

func _ready() -> void:
	on()

func on():
	add_to_group(ACTIVE_CHECKPOINT)
	dude.connect("dead",self,"revive")
	ship.connect("dead",self,"revive")
	
func off():
	remove_from_group(ACTIVE_CHECKPOINT)
	dude.disconnect("dead",self,"revive")
	ship.disconnect("dead",self,"revive")
	
func revive():
	Text.say("Oh it was just some vivid thought, thank goodness!", 5.0)
	get_tree().reload_current_scene()