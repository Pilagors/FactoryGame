extends Control

@export var inventory: Inventory
@export var slot_scene: PackedScene

@onready var container = $HBoxContainer

func _ready() -> void:
	if inventory:
		inventory.update_ui.connect(_on_inventory_update)
		_on_inventory_update()
		
func _on_inventory_update():
	_refresh_slots()
	
func _refresh_slots():
	var selected = inventory.hotbar_index
	
	for child in container.get_children():
		container.remove_child(child)
		child.queue_free()
		
	for i in range(inventory.hotbar_slots.size()):
		var new_slot: InventorySlot = slot_scene.instantiate()
		container.add_child(new_slot)
		
		new_slot.display_slot(inventory.hotbar_slots[i], i == selected)
