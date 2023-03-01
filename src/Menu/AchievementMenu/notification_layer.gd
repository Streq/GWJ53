extends CanvasLayer


onready var NOTIFICATION = preload("res://src/Menu/AchievementMenu/achievement_notification.tscn")

onready var v_box_container: VBoxContainer = $VBoxContainer

func _ready() -> void:
	Achievements.connect("completed",self,"completed")


func completed(achievement:Achievement):
	
	var notification = NOTIFICATION.instance()
	notification.texture = achievement.icon_texture
	notification.title = achievement.title
	notification.requirement = achievement.description
	v_box_container.add_child(notification)
	yield(get_tree().create_timer(5.0,true),"timeout")
	notification.queue_free()
