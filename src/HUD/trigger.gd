extends Node

signal triggered()

func trigger(
	_A = null, 
	_B = null, 
	_C = null, 
	_D = null, 
	_E = null, 
	_F = null, 
	_H = null, 
	_I = null
):
	emit_signal("triggered")
