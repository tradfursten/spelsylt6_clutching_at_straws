extends KinematicBody2D

var inventory = preload("res://assets/items/inventory.tres")

const HORIZONTAL_MOVEMENT = 70
const VERTICAL_MOVEMENT = 20

var gravity = 100
var velocity = Vector2()

var dead = false
var input_disabled = false
var item = null

func _ready() -> void:
	$AnimationPlayer.play("falling_right")
	$sun.global_position = Vector2(510, -270)
	$sun.visible = false
	$Camera2D.limit_right = 100000
	$Camera2D.limit_top = -100000

func _physics_process(_delta: float) -> void:
		
	velocity.y = gravity
	
	if not input_disabled:
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
		dead = true
		input_disabled = true
		print("dead")
		Audioplayer.stop_wind()
		Audioplayer.play_hit_ground()
		$BloodSplaterComponent.splatter()
		$AnimationPlayer.play("dead")
		if item != null:
			match item.name:
				"Anvil":
					SignalManager.emit_signal("death", "anvil")
		else:
			SignalManager.emit_signal("death", "ground")
		$GameOverTimer.start()

func _on_KinematicBody2D_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_released("ui_left_mouse") and inventory.drag_data != null:
		if inventory.drag_data is Dictionary:
			item = inventory.drag_data.item
			dead = true
			input_disabled = true
			match inventory.drag_data.item.name:
				"Anvil":
					Audioplayer.play_activate()
					$AnimationPlayer.play("holding_anvil")
					$EffectTimer.start()
				"Chicken":
					Audioplayer.play_activate()
					$AnimationPlayer.play("holding_chicken")
					gravity = 20
					$EffectTimer.start(0.7)
				"Blood":
					Audioplayer.play_activate()
					bat()
				"Straw":
					Audioplayer.play_activate()
					straw()
				"Large Chicken":
					Audioplayer.play_activate()
					$EffectTimer.start(0.7)
				"Matches":
					Audioplayer.play_activate()
					$AnimationPlayer.play("in_flames")
				"Flour":
					Audioplayer.play_activate()
					SignalManager.emit_signal("cutscene", "Flour")
				"Loaf of bread":
					Audioplayer.play_activate()
					SignalManager.emit_signal("cutscene", "LoafOfBreadCutscene")
				_:
					dead = false
					input_disabled = false
					
		inventory.drag_data = null
		
func bat():
	$AnimationPlayer.play("bat")
	$Particles2D.emitting = false
	input_disabled = true
	gravity = 0
	SignalManager.emit_signal("death", "blood")
	
func straw():
	$Particles2D.emitting = false
	input_disabled = true
	gravity = 0
	$AnimationPlayer.play("flying_straws")
	SignalManager.emit_signal("cutscene", "IcarosCutscene")
	
func large_chicken():
	$AnimationPlayer.play("exploding_chicken")
	
func _on_EffectTimer_timeout() -> void:
	match item.name:
		"Anvil" :
			gravity = 2000
		"Chicken":
			SignalManager.emit_signal("cutscene", "Chicken")
		"Large Chicken":
			large_chicken()

func game_over() -> void:
	SignalManager.emit_signal("cutscene", "game_over")

func _on_GameOverTimer_timeout() -> void:
	SignalManager.emit_signal("cutscene", "game_over")

func audio_chicken_explosion():
	Audioplayer.play_chicken_explosion()
	
func _on_chicken_explosion():
	SignalManager.emit_signal("death", "large chicken")
	SignalManager.emit_signal("cutscene", "game_over")

func _on_in_flames_done():
	SignalManager.emit_signal("death", "in flames")
	SignalManager.emit_signal("cutscene", "game_over")

func play_burn():
	Audioplayer.play_burn()
	
