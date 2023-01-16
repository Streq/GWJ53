extends Camera2D

var shaking = false

export var distance := 1.0
export var frames_between_shakes := 5
export var shakes := 3

func _ready() -> void:
	Shake.connect("shake",self,"shake")


func shake(direction := Vector2.RIGHT):
	if shaking:
		return
	shaking = true
	var _offset = (direction * distance)
	offset = (_offset*1.5).snapped(Vector2(1,1))
	
	for j in frames_between_shakes:
		yield(get_tree(),"idle_frame")
	offset = _offset.snapped(Vector2(1,1))
	
	for i in shakes-1:
		offset = -offset
		for j in frames_between_shakes:
			yield(get_tree(),"idle_frame")
	
	offset = Vector2()
	shaking = false
