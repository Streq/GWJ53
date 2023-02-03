extends Node


func _ready() -> void:
	SessionState.skip_intro = true
	
	
	var i = 0
	for sample in Group.get_all("bio_sample"):
		if SessionState.flowers[i]:
			sample.queue_free()
			sample.emit_signal("collected")
		else:
			sample.connect("collected", self, "flower_collected", [i])
		i+=1
	
	i = 0
	for checkpoint in Group.get_all("checkpoint"):
		checkpoint.connect("active",self,"active_checkpoint",[i])
		if i == SessionState.current_checkpoint:
			checkpoint.on()
			checkpoint.revive_quick()
		i+=1
		
	
	for pickup in Group.get_all("pickup"):
		var component = pickup.ship_component
		if SessionState.get_component(component.component_flag):
			pickup.connect_to_ship($"%ship")
			continue
		component.connect("connected", self, "component_done", [component.component_flag])
	
func component_done(index:int):
	SessionState.set_component(index)

func flower_collected(index:int):
	SessionState.set_flower(index)

func active_checkpoint(checkpoint:int):
	SessionState.set_checkpoint(checkpoint)
