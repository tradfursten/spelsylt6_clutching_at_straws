extends KinematicBody2D
var inventory = preload("res://assets/items/inventory.tres")

const HORIZONTAL_MOVEMENT = 30
const VERTICAL_MOVEMENT = 20

var gravity = 100
var velocity = Vector2()

var dead = false
var item = null

func _ready() -> void:
	$AnimationPlayer.play("falling")


func _physics_process(delta: float) -> void:
	if dead:
		return
		
	velocity.y = gravity
	
	var x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	velocity.x = x * HORIZONTAL_MOVEMENT
	velocity.y = velocity.y + (x*VERTICAL_MOVEMENT)
	if x < 0:
		$AnimatedSprite.flip_h = true
	elif x > 0:
		$AnimatedSprite.flip_h = false
	
	velocity = move_and_slide(velocity)

func hit_ground():
	if not dead:
		$BloodSplaterComponent.splatter()
		$AnimationPlayer.play("dead")
	else:
		dead = true

func can_drop_data(_pos, data):
	print(data)


func _on_KinematicBody2D_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_released("ui_left_mouse") and inventory.drag_data != null:
		print(get_viewport().get_mouse_position())
		if inventory.drag_data is Dictionary:
			item = inventory.drag_data.item
			print(inventory.drag_data.item)
			match inventory.drag_data.item.name:
				"Anvil":
					$AnimationPlayer.play("holding_anvil")
					$EffectTimer.start()


			
		inventory.drag_data = null


func _on_EffectTimer_timeout() -> void:
	match item.name:
		"Anvil" :
			gravity = 2000
