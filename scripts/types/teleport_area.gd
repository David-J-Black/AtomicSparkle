extends Area3D
class_name TeleportArea

## Not needed. If a level name is specified, the player will be teleported
## to an area in that level
@export var level_name: String = ""

## What is the name of the spawn the player should be sent to?
@export var spawn_name: String = ""

@onready var collision_shape: CollisionShape3D = $CollisionShape3D

func _physics_process(delta: float) -> void:
	var overlapping_bodies: Array[Node3D] = get_overlapping_bodies()
	
	for body in overlapping_bodies:
		#print("Teleport [%s] interacting with [%s]" % [name, body.name])
		if body.name == 'Player':
			#print("PLAYER IS THAT YOU??")
				
			if level_name != "":
				LevelService.load_level(level_name, spawn_name)
