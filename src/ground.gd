extends Node2D

signal hit_ground

func _on_Area2D_body_entered(body: Node) -> void:
	print("Ground entered by: " + body.name)
	if body.name == "Player":
		emit_signal("hit_ground")
