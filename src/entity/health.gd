extends Node

onready var bar: Node = $bar

func take_damage(amount):
	bar.value -= amount

func heal(amount):
	bar.value += amount

func _on_bar_empty() -> void:
	owner.die()
