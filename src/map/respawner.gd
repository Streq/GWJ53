extends Node2D
export var SPAWN_NODE : PackedScene

func _ready() -> void:
	yield(owner,"ready")
	set_up_respawns()
	
func set_up_respawns():
	var respawnables = get_tree().get_nodes_in_group("respawnable")
	for _r in respawnables:
		var respawnable : Node2D = _r
		
		var prototype = respawnable.duplicate()
		
		var respawn_point = SPAWN_NODE.instance()
		
		respawn_point.prototype = prototype
		respawn_point.current_instance = respawnable
		
		var parent = respawnable.get_parent()
		parent.add_child_below_node(respawnable, respawn_point)
		
