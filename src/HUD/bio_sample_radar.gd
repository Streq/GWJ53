extends Node2D

var samples = []

export var GROUP := "bio_sample"

export var indicator : Texture
func _ready() -> void:
	yield(owner,"ready")
	update_radar()
func update_radar():
	samples = get_tree().get_nodes_in_group(GROUP)
	
	
func _process(delta: float) -> void:
	update()
func _draw() -> void:
	for sample in samples:
		if is_instance_valid(sample) and "global_position" in sample:
			draw_arrow(sample.global_position)


func draw_arrow(target_position):
	var vp_transform = get_viewport_transform()
	
#	print(vp_transform.get_origin())
	
	var screen_dims = get_viewport_rect().size
	var relative_pos = vp_transform.xform(target_position)
	
#	var dir = Vector2()
#
#	dir = (relative_pos-screen_dims/2)

	
	var x = clamp(relative_pos.x, 0, screen_dims.x)
	var y = clamp(relative_pos.y, 0, screen_dims.y)
	
	if x > 0 and x < screen_dims.x and y > 0 and y < screen_dims.y:
		return

	
	
	var screen_cords = vp_transform.xform_inv(Vector2(x,y))

	draw_texture(indicator,screen_cords-indicator.get_size()*0.5)
#	draw_circle(, 4, Color("010102"))
	
