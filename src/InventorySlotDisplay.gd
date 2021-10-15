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
		inventory.drag_data = data
		return data
	
func can_drop_data(_position, data):
	return data is Dictionary and data.has("item")
	
func drop_data(_position: Vector2, data) -> void:
	print("Drop data: " + data.item.name)
	var my_item_index = get_index()
	var my_item = inventory.items[my_item_index]


	var new_item = my_item.combine(data.item)
	print("Combine " + data.item.name + " with " + my_item.name + " = " + new_item.name)
	if new_item != null:
		inventory.set_item(my_item_index, new_item)
	else:
		inventory.set_item(data.item_index, data.item)
	
	inventory.drag_data = null
	
	
