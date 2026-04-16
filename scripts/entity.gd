class_name Entity
extends CharacterBody3D

enum EntityState { IDLE, MOVING, INTERACTING, BUSY }

@export var state: EntityState = EntityState.IDLE
@export var move_speed: float = 10.0
@export var inventory: Inventory = Inventory.new()

func _ready() -> void:
	for i in range(9):
		inventory.hotbar_slots.append(Slot.new())
	for i in range(27):
		inventory.backpack_slots.append(Slot.new())

func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	_update_movement(delta)
	move_and_slide()
	
func _apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func _update_movement(delta: float) -> void:
	pass # override
	
func interact(target: Node) -> void:
	pass # override
	
func _update_state(new_state: EntityState) -> void:
	state = new_state
