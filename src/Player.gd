extends KinematicBody2D

signal cutscene(scene)

var inventory = preload("res://assets/items/inventory.tres")

const HORIZONTAL_MOVEMENT = 40
const VERTICAL_MOVEMENT = 20

var gravity = 100
var velocity = Vector2()

var dead = false
var item = null

func _ready() -> void:
	$AnimationPlayer.play("falling_right")



func _physics_process(delta: float) -> void:
	if dead:
		return
		
	velocity.y = gravity
	
	var x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	velocity.x = x * HORIZONTAL_MOVEMENT
	velocity.y = velocity.y + (y * VERTICAL_MOVEMENT)
	
	if x < 0:
		$AnimationPlayer.play("falling_left")
	elif x > 0:
		$AnimationPlayer.play("falling_right")
	
	velocity = move_and_slide(velocity)

func hit_ground():
	if not dead:
		$BloodSplaterComponent.splatter()
		$AnimationPlayer.play("dead")
	else:
		dead = true


func _on_KinematicBody2D_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_released("ui_left_mouse") and inventory.drag_data != null:
		if inventory.drag_data is Dictionary:
			item = inventory.drag_data.item
			match inventory.drag_data.item.name:
				"Anvil":
					$AnimationPlayer.play("holding_anvil")
					$EffectTimer.start()
				"Chicken":
					$AnimationPlayer.play("holding_chicken")
					gravity = 20
					$EffectTimer.start(0.7)
				"Blood":
					$AnimationPlayer.play("bat")
					$Particles2D.emitting = false
					gravity = 0
			
		inventory.drag_data = null


func _on_EffectTimer_timeout() -> void:
	match item.name:
		"Anvil" :
			gravity = 2000
		"Chicken":
			SignalManager.emit_signal("cutscene", "Chicken")
