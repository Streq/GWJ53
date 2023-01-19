extends TileMap

const DESTRUCTIBLE_TILES = {
	11:12,
	12:13,
	13:14,
	14:-1
}


func hit_destructible_terrain(point: Vector2):
	var local = to_local(point)
	var map_coord = world_to_map(point)
	var tile_id = get_cellv(map_coord)
	if tile_id in DESTRUCTIBLE_TILES:
		set_cellv(map_coord,DESTRUCTIBLE_TILES[tile_id])

func terrain_get_hit(bullet, collision:KinematicCollision2D):
	hit_destructible_terrain(collision.position-collision.normal)
	pass
