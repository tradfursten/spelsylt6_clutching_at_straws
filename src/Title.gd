extends Node2D

signal level_completed
signal level_failed

func _ready() -> void:
	pass

func get_name():
	"Title"

func _on_Button_pressed() -> void:
	print("Button pressed")
	emit_signal("level_completed", "Title")
