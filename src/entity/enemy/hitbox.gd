extends Area2D

export var damage := 1.0
export var knockback := Vector2()



func _on_hitbox_area_entered(area: Area2D) -> void:
	area.get_hurt(self)
	
