extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_select"):
		print("restart")
		Audioplayer.play_select()
		SignalManager.emit_signal("restart")
