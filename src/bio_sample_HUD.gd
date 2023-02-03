extends Label

signal done()

var total_samples = 0
var collected_samples = 0
var padding = ""
var original_format = "d/%d bio samples collected"
var format = original_format

func _ready() -> void:
	var samples = Group.get_all("bio_sample")
	total_samples = samples.size()
	padding = str(str(total_samples).length())
	for sample in samples:
		sample.connect("collected",self,"collected_sample")
	update_display()
	LocaleMenu.connect("locale_changed",self,"update_display")
	
func update_display():
	update_format()
	update_text()

func update_format():
	format = "%"+padding+tr(original_format)

	
func update_text():
	text = format % [collected_samples,total_samples]

func collected_sample():
	collected_samples += 1
	update_text()
	if collected_samples == total_samples:
		emit_signal("done")
