class_name DroppedItem
extends RigidBody3D

@export var item: Item
@onready var pickup_zone: Area3D = $PickupZone

func _ready() -> void:
	pickup_zone.body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		if body.inventory.add_item(item):
			queue_free()
