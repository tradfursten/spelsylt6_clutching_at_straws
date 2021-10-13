extends Node2D


var dead = false

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_select"):
		$BloodSplaterComponent.splatter(64)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
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

