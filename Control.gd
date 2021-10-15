extends CanvasLayer

var deaths = []

func _ready() -> void:
	SignalManager.connect("death", self, "_on_death")

func _on_death(death):
	if !deaths.has(death):
		deaths.push_back(death)
		print("Update deaths to: " + str(deaths.size()))
		$Label.text = str(deaths.size())
