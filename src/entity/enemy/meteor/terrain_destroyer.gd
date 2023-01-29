extends Area2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_body_shape_entered(
	body_rid: RID, 
	body: Node, 
	body_shape_index: int, 
	local_shape_index: int
) -> void:
#	print(body_rid)
#	print(body)
#	print(body_shape_index)
#	print(local_shape_index)
	var body_rid_instance = RID(body_rid)
	var coordinate: Vector2 = Physics2DServer.body_get_shape_metadata(body_rid_instance, body_shape_index)
	if body.has_method("hit_destructible_terrain"):
		body.hit_destructible_terrain(body.map_to_world(coordinate),10,true)
	pass # Replace with function body.
