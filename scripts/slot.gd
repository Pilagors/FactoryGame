class_name Slot
extends Resource

@export var item: Item = null
@export var quantity: int = 0
@export var limit: int = 100

func increment_item(count: int) -> bool:
	if count + quantity > limit:
		return false
	
	quantity += count
	return true
