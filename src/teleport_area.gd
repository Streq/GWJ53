extends Polygon2D


onready var dude: KinematicBody2D = $"%dude"


onready var triangles = GeometryUtils.get_triangulated(polygon)
onready var areas = GeometryUtils.get_triangle_areas(triangles)

func get_point():
	var point : Vector2
	var dude_pos = to_local(dude.global_position)
	for i in 10:
		point = GeometryUtils.random_point_in_triangles(triangles, areas)
		
		if point.distance_squared_to(dude_pos) > 320*320:
			break
	return global_transform.xform(point)
