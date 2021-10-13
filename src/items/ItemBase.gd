extends Area2D

export(Texture) var texture
export(Resource) var item

signal pick_up_item



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite.texture = texture



func _on_Item_body_entered(body: Node) -> void:
	emit_signal("pick_up_item", self, item)
