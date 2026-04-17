class_name InventorySlot
extends PanelContainer

@onready var mesh: MeshInstance3D = $SubViewportContainer/SubViewport/Mesh
@onready var quantity_label = $Quantity
@onready var background: TextureRect = $Background

func display_slot(slot: Slot):
	if slot and slot.item:
		mesh.mesh = slot.item.mesh
		background.hide()
		mesh.show()
		
		
		if slot.quantity > 1:
			quantity_label.text = str(slot.quantity +1 )
			quantity_label.show()
		else:
			quantity_label.hide()
			
	else:
		mesh.mesh = null
		quantity_label.hide() 
