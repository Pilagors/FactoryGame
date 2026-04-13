class_name Entity
extends CharacterBody3D

enum EntityState { IDLE, MOVING, INTERACTING, BUSY }

var state: EntityState = EntityState.IDLE
var move_speed: float = 100.0

func move_to(target: Vector3) -> void:
	pass # override
	
func interact(target: Node) -> void:
	pass # override
	
func _update_state(new_state: EntityState) -> void:
	state = new_state
