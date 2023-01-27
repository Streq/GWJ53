extends Node2D
signal fire()

export var BULLET : PackedScene
export var firing := false setget set_firing  
var shooting_muzzles = 0
onready var cooldown: Timer = $cooldown
onready var autofire_cooldown: Timer = $autofire_cooldown

onready var exit: Node2D = $exit
onready var wearer = owner if !wearer else wearer

var just_started_firing = false

func set_firing(val):
	just_started_firing = val and !firing
	firing = val
	

func start():
	set_firing(true)

func stop():
	set_firing(false)

func _physics_process(delta: float) -> void:
	if !just_started_firing and !autofire_cooldown.is_stopped() or !cooldown.is_stopped():
		return
	if firing:
		emit_signal("fire")
		cooldown.start()
		autofire_cooldown.start()
