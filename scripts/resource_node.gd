class_name ResourceNode
extends StaticBody3D

@export var produce: Item
@export var quantity: int = 5
@export var tool: UsableItem.ToolType = UsableItem.ToolType.NONE

func interact(player: Player) -> void:
	if _has_correct_tool(player):
		_extract_resource(player)
	else:
		print("Outil pas bon")
		
func _has_correct_tool(player: Player) -> bool:
	if tool == UsableItem.ToolType.NONE:
		return true
	# à faire
	return false

func _extract_resource(player: Player) -> void:
	if quantity > 0:
		quantity -= 1
		print("Resource ", produce.name, " +1")
		
		# apparition de l'item au sol ou inventaire
