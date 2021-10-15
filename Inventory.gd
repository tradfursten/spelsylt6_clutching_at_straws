extends Resource
class_name Inventory

signal items_changed(indexes)
signal item_added(item)

var drag_data = null

export(Array, Resource) var items = [
]

func set_item(item_index, item):
	var previous_item = items[item_index]
	items[item_index] = item
	emit_signal("items_changed", [item_index])
	return previous_item
	
func swap_items(item_index, target_item_index):
	var previous_item = items[item_index]
	items[item_index] = items[target_item_index]
	items[target_item_index] = previous_item
	emit_signal("items_changed", [item_index, target_item_index])

	
func remove_item(item_index):
	var previous_item = items[item_index]
	items[item_index] = null
	emit_signal("items_changed", [item_index])
	return previous_item

func add_item(item):
	items.push_back(item)
	emit_signal("item_added", item)
 
func reset():
	items = []
