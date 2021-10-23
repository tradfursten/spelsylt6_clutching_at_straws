extends Node2D

func get_name():
	"Icaros"
	
func _ready():
	$Camera2D.current = true
	$AnimationPlayer.play("icaros")
	Audioplayer.play_fly()
	
func burn():
	Audioplayer.play_burn()
	
func game_over() -> void:
	SignalManager.emit_signal("cutscene", "game_over")
	SignalManager.emit_signal("death", "icaros")

