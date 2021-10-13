extends GridContainer

var inventory = preload("res://assets/items/inventory.tres")
var InventorySlotDisplay = preload("res://src/InventorySlotDisplay.tscn")

func _ready() -> void:
	inventory.connect("item_added", self, "_on_item_added")
	inventory.connect("items_changed", self, "_on_items_changed")
	update_inventory_display()
	
func update_inventory_display():
	for item_index in inventory.items.size():
		update_inventory_slot_display(item_index)
		
func update_inventory_slot_display(item_index):
	var inventory_slot_item = get_child(item_index)
	var item = inventory.items[item_index]
	inventory_slot_item.display_item(item)
	
func _on_items_changed(indexes):
	for item_index in indexes:
		update_inventory_slot_display(item_index)

func _on_item_added(item):
	var new_slot = InventorySlotDisplay.instance()
	new_slot.display_item(item)
	add_child(new_slot)
	
