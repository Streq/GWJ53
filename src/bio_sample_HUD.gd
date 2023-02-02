extends Label

signal done()

var total_samples = 0
var collected_samples = 0
var padding = ""
var format = "d/%d bio samples collected"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	yield(owner,"ready")
	var samples = Group.get_all("bio_sample")
#	print(samples)
	total_samples = samples.size()
	
	for sample in samples:
		sample.connect("collected",self,"collected_sample")
	
	padding = str(str(total_samples).length())
#	print(padding)
	format = "%"+padding+format
#	print(format)
	update_text()
	
func update_text():
	text = format % [collected_samples,total_samples]

func collected_sample():
	collected_samples += 1
	update_text()
	if collected_samples == total_samples:
		emit_signal("done")
