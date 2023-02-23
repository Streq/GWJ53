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
	yield(get_tree().create_timer(2.0), "timeout")
	revive_quick()
	
func revive_quick():
	Text.clear_queue()
	Text.clear()

	Text.say("Oh it was just some vivid thought, thank goodness!", 5.0)
	get_tree().reload_current_scene()
