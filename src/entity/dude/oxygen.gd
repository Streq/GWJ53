extends Node
signal drown
signal not_full
signal full
onready var bar: Node = $bar
onready var head: Area2D = $"../head"


func _physics_process(delta: float) -> void:
	if !bar.value:
		emit_signal("drown")
		return
	if head.get_overlapping_areas():
		bar.value-=delta
		emit_signal("not_full")
	else:
		bar.value += delta * 10.0

func fill(amount):
	bar.value+=amount
