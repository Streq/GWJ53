extends Node2D

var target:Node2D
export var texture : Texture
func _ready() -> void:
	target = Group.get_one("player")

func _process(delta: float) -> void:
	update()
	
func _draw() -> void:
	if !is_instance_valid(target):
		return
		
	var dst = target.global_position
	var src = global_position
	var distance = dst-src
	var steps = distance.length()/8.0
	for i in steps:
		draw_texture(texture, distance/steps*i)
	
