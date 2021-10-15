extends Node2D
var inventory = preload("res://assets/items/inventory.tres")

func get_name():
	"Falling"

func _ready() -> void:
	inventory.reset()
	for child in $items.get_children():
		child.connect("pick_up_item", self, "_on_pick_up_item")

func _physics_process(delta: float) -> void:
	if Input.is_action_just_released("ui_left_mouse") and inventory.drag_data != null:
		inventory.set_item(inventory.drag_data.item_index, inventory.drag_data.item)
		print("Dropped item " + inventory.drag_data.item.name)


func _on_Area2D_body_entered(body: Node) -> void:
	if body.name == "Player":
		$Player.call_deferred("hit_ground")


func _on_pick_up_item(child, item):
	print("Pick up " + item.name)
	Audioplayer.play_pick_up()
	inventory.add_item(item)
	child.queue_free()
	

