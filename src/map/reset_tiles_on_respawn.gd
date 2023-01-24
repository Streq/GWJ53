extends Node

var data = null


func _ready() -> void:
	yield(get_parent(),"ready")
	var tilemap : TileMap = get_parent()
	data = tilemap.get("tile_data")


func trigger():
	get_parent().set("tile_data", data)
