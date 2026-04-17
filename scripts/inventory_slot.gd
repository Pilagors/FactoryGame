class_name InventorySlot
extends PanelContainer

@onready var mesh: MeshInstance3D = $SubViewportContainer/SubViewport/Mesh
@onready var quantity_label = $Quantity

var selected: bool = false

func _process(delta: float) -> void:
	if selected and mesh.mesh != null:
		mesh.rotation += Vector3(0, 1, 0) * delta

func display_slot(slot: Slot, s: bool):
	selected = s
	set_highlighted()
	if slot and slot.item:
		mesh.mesh = slot.item.mesh
		mesh.show()
		await get_tree().process_frame
		
		_fit_in_view.call_deferred()
		
		if slot.quantity > 1:
			quantity_label.text = str(slot.quantity)
			quantity_label.show()
		else:
			quantity_label.hide()
			
	else:
		mesh.mesh = null
		quantity_label.hide()
		
func _fit_in_view():
	if mesh.mesh == null:
		return
	
	var sub_viewport: SubViewport = $SubViewportContainer/SubViewport
	var camera: Camera3D = sub_viewport.get_camera_3d()
	
	var aabb = mesh.mesh.get_aabb()
	var max_dimension = max(aabb.size.x, max(aabb.size.y, aabb.size.z))
	
	if max_dimension <= 0: return
	
	mesh.position = -aabb.get_center()
	var ratio = float(sub_viewport.size.x) / float(sub_viewport.size.y)
	
	if ratio >= 1.0:
		camera.size = max_dimension * 1.1
	else:
		camera.size = (max_dimension / ratio) * 1.1
		
func set_highlighted():
	var style = get_theme_stylebox("panel")
	var new_style = style.duplicate()
	
	if selected:
		new_style.bg_color = Color.SKY_BLUE
		add_theme_stylebox_override("panel", new_style)
		scale = Vector2(1.1, 1.1)
		z_index = 1
	else:
		new_style.bg_color = Color.WEB_GRAY
		add_theme_stylebox_override("panel", new_style)
		scale = Vector2(1.0, 1.0)
		z_index = 0
