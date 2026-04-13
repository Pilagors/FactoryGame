class_name Player
extends Entity

const MOUSE_SENSITIVITY := 0.002
const PITCH_LIMIT := deg_to_rad(80)

@onready var pivot := $Pivot
@onready var camera: Camera3D = $Pivot/Camera3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		pivot.rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		camera.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, -PITCH_LIMIT, PITCH_LIMIT)
		
	if event.is_action_pressed("debug_mouse"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
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
	
	
