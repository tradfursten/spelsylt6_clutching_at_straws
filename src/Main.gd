extends Node2D
var inventory = preload("res://assets/items/inventory.tres")

func _ready() -> void:
	for child in $items.get_children():
		child.connect("pick_up_item", self, "_on_pick_up_item")

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		get_tree().reload_current_scene()


func _on_Area2D_body_entered(body: Node) -> void:
	$Player.hit_ground()


func _on_pick_up_item(child, item):
	print("Pick up " + item.name)
	inventory.add_item(item)
	child.queue_free()
	
