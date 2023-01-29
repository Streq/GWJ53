extends Node
signal heal()
onready var bar: Node = $bar

func is_full():
	return bar.is_full()

func take_damage(amount):
	bar.value -= amount
	print(bar.value)

func heal(amount):
	bar.value += amount
func _on_bar_empty() -> void:
	owner.die()
