extends Node2D

signal shrink_step

signal done

func shrink():
	var tilemap : TileMap = get_parent()
	var cell_to_shrink_toward = tilemap.world_to_map(tilemap.to_local(global_position))
	while true:
		var new_set_cells = []
		var cells_to_remove = []
		if tilemap.get_used_cells().size() == 1:
			owner.queue_free()
			SFX.play("lava_shrink_end",owner.global_position)
			emit_signal("done")
			return
		for cell in tilemap.get_used_cells():
			var distance = cell_to_shrink_toward-cell
			
			if distance.x:
				var offset = Vector2(sign(distance.x),0)
				if tilemap.get_cellv(cell+offset) == -1:
					new_set_cells.append(cell+offset)
				if tilemap.get_cellv(cell-offset) == -1:
					cells_to_remove.append(cell)
				
			if distance.y:
				var offset = Vector2(0,sign(distance.y))
				if tilemap.get_cellv(cell+offset) == -1:
					new_set_cells.append(cell+offset)
				if tilemap.get_cellv(cell-offset) == -1:
					cells_to_remove.append(cell)
		if new_set_cells:
			yield(self,"shrink_step")
			for cell in new_set_cells:
				tilemap.set_cellv(cell, 0)
			tilemap.update_bitmask_region()
		if cells_to_remove:
			yield(self,"shrink_step")
			for cell in cells_to_remove:
				tilemap.set_cellv(cell, -1)
			tilemap.update_bitmask_region()
#		yield(self,"shrink_step")


func shrink_step():
	emit_signal("shrink_step")
