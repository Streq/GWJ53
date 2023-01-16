extends Node2D
onready var grab_ray: RayCast2D = $grab_ray
onready var ungrabbable: Area2D = $ungrababble


func get_ledge():
	if ungrabbable.get_overlapping_bodies():
		return null
	if !grab_ray.is_colliding():
		return null
	var ledge = grab_ray.get_collision_point()
	return ledge
	
