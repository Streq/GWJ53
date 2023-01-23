extends Node2D
onready var grab_ray: RayCast2D = $grab_ray
onready var ungrabbable: Area2D = $ungrababble
onready var floor_check: RayCast2D = $floor_check


func get_ledge():
	if ungrabbable.get_overlapping_bodies():
		return null
	if !grab_ray.is_colliding():
		return null
	var ledge = grab_ray.get_collision_point()
	return ledge
	
func can_stand():
	floor_check.force_raycast_update()
	return floor_check.is_colliding()
