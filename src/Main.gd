extends Node2D

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		get_tree().reload_current_scene()


func _on_Area2D_body_entered(body: Node) -> void:
	$Player.hit_ground()

