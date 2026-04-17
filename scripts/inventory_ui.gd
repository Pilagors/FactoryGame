extends Control

@export var inventory: Inventory
@export var slot_scene: PackedScene

@onready var container = $HBoxContainer

func _ready() -> void:
	if inventory:
		inventory.update_ui.connect(_on_inventory_update)
		_on_inventory_update()
		
func _on_inventory_update():
	print('New item in inventory!')
	_refresh_slots()
	
func _refresh_slots():
	for child in container.get_children():
		child.queue_free()
		
	for slot in inventory.hotbar_slots:
		var new_slot: InventorySlot = slot_scene.instantiate()
		container.add_child(new_slot)
		
		new_slot.display_slot(slot)
