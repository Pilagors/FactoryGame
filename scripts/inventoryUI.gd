extends Control

@export var inventory: Inventory

func _ready() -> void:
	if inventory:
		inventory.update_ui.connect(_on_inventory_update)
		_on_inventory_update()
		
func _on_inventory_update():
	print('New item in inventory!')
	_refresh_slots()
	
func _refresh_slots():
	pass
