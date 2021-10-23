extends Node2D

func _ready() -> void:
	$Player/AnimatedSprite.play("default")

func _on_Area2D_body_entered(body: Node) -> void:
	$Area2D/CollisionShape2D.disabled = true
	$BloodSplaterComponent.splatter(64)
	$Player/AnimatedSprite.play("dead")
	Audioplayer.play_hit_ground()
	$Timer.start(3)


func _on_Timer_timeout() -> void:
	SignalManager.emit_signal("death", "flour")
	SignalManager.emit_signal("cutscene", "game_over")
