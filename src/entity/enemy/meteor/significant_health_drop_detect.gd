extends Node
signal trigger()

onready var rest_time: Timer = $rest_time

onready var health: Node = $"%health"

export var damage_threshold := 37.5

var damage_accum := 0.0

func _ready() -> void:
	health.connect("damage",self,"took_damage")
	rest_time.connect("timeout",self,"rest_time_over")

func took_damage(amount):
	damage_accum+=amount
	rest_time.start()
	if damage_threshold < damage_accum:
		if health.bar.value != 0:
			emit_signal("trigger")
		damage_accum = 0.0

func rest_time_over():
	damage_accum = 0.0
