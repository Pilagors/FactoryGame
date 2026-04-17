class_name Slot
extends Resource

@export var item: Item = null
@export var quantity: int = 0

func increment_item(count: int) -> bool:
	if count + quantity > item.limit:
		return false
	
	quantity += count
	return true
