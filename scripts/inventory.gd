class_name Inventory
extends Resource

signal update_ui

@export var hotbar_slots: Array[Slot] = []
@export var backpack_slots: Array[Slot] = []

func _find_item_slot(slots: Array[Slot], item: Item) -> int:
	for i in range(slots.size()):
		if slots[i] and slots[i].item == item and slots[i].limit != slots[i].quantity:
			return i
	return -1

func _find_empty_slot(slots: Array[Slot]) -> int:
	for i in range(slots.size()):
		if slots[i] and slots[i].item == null:
			return i
	return -1

func add_item(new_item: Item, amount: int = 1) -> bool:
	var index = _find_item_slot(hotbar_slots, new_item)
	if index != -1:
		hotbar_slots[index].quantity += amount
		update_ui.emit()
		return true
		
	index = _find_item_slot(backpack_slots, new_item)
	if index != -1:
		backpack_slots[index].quantity += amount
		update_ui.emit()
		return true
		
	var empty_index = _find_empty_slot(hotbar_slots)
	if empty_index != -1:
		hotbar_slots[empty_index].item = new_item
		hotbar_slots[empty_index].quantity = amount
		update_ui.emit()
		return true
		
	empty_index = _find_empty_slot(backpack_slots)
	if empty_index != -1:
		backpack_slots[empty_index].item = new_item
		backpack_slots[empty_index].quantity = amount
		update_ui.emit()
		return true
		
	return false
