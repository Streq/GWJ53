extends Area2D

signal triggered()


func _ready() -> void:
	connect("area_entered",self,"_area_entered")
	connect("body_entered",self,"_body_entered")

func _area_entered(area):
	trigger()
func _body_entered(body):
	trigger()

func trigger():
	emit_signal("triggered")
	queue_free()
