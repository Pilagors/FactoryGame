class_name DroppedItem
extends Area3D

@export var item: Item

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		body.inventory.append(item)
		queue_free()
