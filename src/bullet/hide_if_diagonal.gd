extends Node

enum DIRECTION{
	DIAGONAL,
	ORTHOGONAL
}

export (DIRECTION) var hide_when := DIRECTION.DIAGONAL

func _process(delta: float) -> void:
	var angle = get_parent().global_rotation_degrees
	var is_diagonal = abs(fposmod(angle, 90.0)-45.0)<10.0
#	print (is_diagonal)
	get_parent().visible = (
		(hide_when == DIRECTION.DIAGONAL and is_diagonal) 
		or (hide_when == DIRECTION.ORTHOGONAL and !is_diagonal)
	)
