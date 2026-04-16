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
	var total = amount
	var all_slots = hotbar_slots + backpack_slots
	
	for slot in all_slots:
		if slot and slot.item == new_item:
			var space_left = slot.limit - slot.quantity
			
			if space_left > 0:
				var amount_to_add = min(amount, space_left)
				slot.quantity += amount_to_add
				amount -= amount_to_add
		if amount <= 0: break
	
	if amount > 0:
		for slot in all_slots:
			if slot and slot.item == null:
				slot.item = new_item
				var amount_to_add = min(amount, slot.limit)
				slot.quantity = amount_to_add
				amount -= amount_to_add
				
			if amount <= 0: break
			
	if amount < total:
		update_ui.emit()
		return true
		
	return false
