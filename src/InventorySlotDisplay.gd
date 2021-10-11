extends CenterContainer

var inventory = preload("res://assets/items/inventory.tres")

func display_item(item):
	if item is Item:
		$TextureRect.texture = item.texture
	else:
		$TextureRect.texture = load("res://assets/items/empty_inventory.png")
		
func get_drag_data(_position):
	var item_index = get_index()
	var item = inventory.remove_item(item_index)
	if item is Item:
		var data = {}
		data.item = item
		data.item_index = item_index
		
		var drag_preview = TextureRect.new()
		drag_preview.texture = item.texture
		set_drag_preview(drag_preview)
		return data
	
func can_drop_data(_position, data):
	return data is Dictionary and data.has("item")
	
func drop_data(_position: Vector2, data) -> void:
	pass
	
