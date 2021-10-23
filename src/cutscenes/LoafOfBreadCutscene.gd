extends Node2D


func _ready() -> void:
	$AnimationPlayer.play("default")
	$Player/Camera2D.current = true
	

func _splatter():
	Audioplayer.play_pick()
	$Player/BloodSplaterComponent.splatter(10)
	
func _on_game_over():
	SignalManager.emit_signal("death", "loaf of bread")
	SignalManager.emit_signal("cutscene", "game_over")
