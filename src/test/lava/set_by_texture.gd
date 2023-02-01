extends Node

onready var sprite: Sprite = $TextureRect

func _ready() -> void:
	
#	yield(get_parent(),"ready")
	var tilemap = get_parent()
	var texture = sprite.texture
	var data = texture.get_data()
	data.lock()
	for x in texture.get_width():
		for y in texture.get_height():
			var pixel_position = Vector2(x,y)
			if !data.get_pixelv(pixel_position).a:
				continue
			var pixel_center = pixel_position+Vector2(0.5,0.5)
			var global_world_pos = sprite.to_global(pixel_center-(texture.get_size()/2 if sprite.centered else Vector2()))
			var local_world_pos = tilemap.to_local(global_world_pos)
			var cell_pos = tilemap.world_to_map(local_world_pos)
			tilemap.set_cellv(cell_pos, 0)

	data.unlock()
	sprite.queue_free()
	get_parent().update_bitmask_region()
