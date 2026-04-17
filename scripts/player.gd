class_name Player
extends Entity

signal update_show

const MOUSE_SENSITIVITY := 0.002
const PITCH_LIMIT := deg_to_rad(80)

var hotbar_index: int = 0

@onready var pivot := $Pivot
@onready var camera: Camera3D = $Pivot/Camera3D
@onready var interact_cast: RayCast3D = $Pivot/Camera3D/RayCast3D
@onready var holding: MeshInstance3D = $Pivot/Camera3D/Hand/Holding
@onready var reticule: Reticule = $CanvasLayer/UI/Reticule

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		_attempt_interaction()
		
func _attempt_interaction() -> void:
	if interact_cast.is_colliding():
		var target = interact_cast.get_collider()
		if target.has_method("interact"):
			target.interact(self)

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	update_show.connect(_on_active_slot_changed)
	
func _process(delta: float) -> void:
	var target_color = Color.WHITE_SMOKE
	
	if interact_cast.is_colliding():
		var target = interact_cast.get_collider()
		if target.has_method("interact"):
			target_color = Color.BLUE
			
	reticule.update_color(target_color)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			hotbar_index = (hotbar_index - 1 + inventory.hotbar_slots.size()) % inventory.hotbar_slots.size()
			_on_active_slot_changed()
		
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.is_pressed():
			hotbar_index = (hotbar_index + 1) % inventory.hotbar_slots.size()
			_on_active_slot_changed()
	
	if event is InputEventMouseMotion:
		pivot.rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		camera.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, -PITCH_LIMIT, PITCH_LIMIT)
		
	if event.is_action_pressed("debug_mouse"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_active_slot_changed():
	var current_slot = inventory.hotbar_slots[hotbar_index]
	inventory.hotbar_index = hotbar_index
	inventory.update_ui.emit()
	_show_item(current_slot.item)

func _update_movement(delta: float) -> void:
	var direction := Vector3.ZERO
	var forward = -pivot.global_transform.basis.z
	var right = pivot.global_transform.basis.x
	
	if Input.is_action_pressed("move_forward"):
		direction += forward
	if Input.is_action_pressed("move_backward"):
		direction -= forward
	if Input.is_action_pressed("move_left"):
		direction -= right
	if Input.is_action_pressed("move_right"):
		direction += right
		
	velocity.x = direction.x * move_speed
	velocity.z = direction.z * move_speed
	
func _show_item(item: Item):
	if item and item.mesh:
		holding.mesh = item.mesh
		holding.show()
		holding.scale = Vector3(3, 3, 3)
	else:
		holding.mesh = null
		holding.hide()
	
