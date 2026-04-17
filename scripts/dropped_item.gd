class_name DroppedItem
extends RigidBody3D

@export var item: Item
@onready var pickup_zone: Area3D = $PickupZone
@onready var gathering_zone: Area3D = $GatheringZone

@export var SPEED: float = 10.0
var player: Player = null

func _ready() -> void:
	pickup_zone.body_entered.connect(_on_pickup_zone_entered)
	gathering_zone.body_entered.connect(_on_gathering_zone_entered)
	gathering_zone.body_exited.connect(_on_gathering_zone_exited)
	
func _on_pickup_zone_entered(body: Node3D) -> void:
	if body is not Player:
		return
	
	if body.inventory.add_item(item):
		queue_free()
		
func _physics_process(delta: float) -> void:
	_move_if_player(delta)

func _move_if_player(delta: float) -> void:
	if player and player.inventory.can_pickup(item):
		freeze = true
		
		var direction = player.global_position - global_position
		direction.normalized()
		
		global_position = global_position.move_toward(player.global_position, SPEED * delta)
	else:
		if freeze == true:
			freeze = false
		
func _on_gathering_zone_entered(body: Node3D) -> void:
	if body is not Player:
		return
	print("j'arrive")
		
	player = body


func _on_gathering_zone_exited(body: Node3D) -> void:
	if body == player:
		player = null
