extends Node2D

signal firing()
signal stopped()

export var power := 100.0

onready var animation_player: AnimationPlayer = $AnimationPlayer

export onready var firing := false setget set_firing  
onready var exit: Node2D = $exit

onready var ship = owner

func set_firing(val):
	firing = val
	if firing:
		animation_player.play("fire")
		emit_signal("firing")
	else:
		animation_player.play("idle")
		emit_signal("stopped")
	
func start():
	set_firing(true)

func stop():
	set_firing(false)



func _physics_process(delta: float) -> void:
	if firing:
		ship.velocity += exit.global_position.direction_to(global_position)*power*delta

func connect_to_slot(slot):
	slot.connect("release",self,"stop")
	slot.connect("trigger",self,"start")


func _on_connected_to(slot) -> void:
	ship = slot.owner

func _on_disconnected_from(slot) -> void:
	ship = null
