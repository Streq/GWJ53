extends Panel
tool
export var title := "" setget set_title
func set_title(val):
	title = val
	$'%title'.text = title

export var requirement := "" setget set_requirement
func set_requirement(val):
	requirement = val
	$'%requirement'.text = requirement

export var texture : Texture setget set_texture
func set_texture(val):
	texture = val
	$'%texture'.texture = texture
