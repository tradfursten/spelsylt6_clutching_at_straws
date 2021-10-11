extends KinematicBody2D


var gravity = 100

var velocity = Vector2()

var dead = false

func _ready() -> void:
	$AnimationPlayer.play("falling")


func _physics_process(delta: float) -> void:
	
	velocity.y = gravity
	
	velocity = move_and_slide(velocity)

func hit_ground():
	velocity.y = 0
	gravity = 0
	if not dead:
		$BloodSplaterComponent.splatter()
		$AnimationPlayer.play("dead")
	else:
		dead = true
