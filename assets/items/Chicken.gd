extends Area2D

export(Resource) var item

signal pick_up_item


func _on_Chicken_body_entered(body: Node) -> void:
	emit_signal("pick_up_item", self, item)

