extends Node2D


var dead = false

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
func get_name():
	"Chicken"

func _on_Anvil_body_entered(_body: Node) -> void:
	if not dead:
		dead = true
		call_deferred("kill_player")

func kill_player():
	print("kill player\n")
	$Player.mode = RigidBody2D.MODE_STATIC
	$Anvil.mode = RigidBody2D.MODE_STATIC
	$Player.rotation_degrees = 0
	$Player/CollisionShape2D.rotation_degrees = 90

	$Player/AnimatedSprite.play("dead")
	$Player.linear_velocity = Vector2()
	$BloodSplaterComponent.splatter(64)
	$Timer.start()

func _on_Timer_timeout() -> void:
	SignalManager.emit_signal("death", "chicken")
	SignalManager.emit_signal("cutscene", "game_over")
