extends Node3D
class_name GameLevel

## All of the entities of the level are children of this node
@onready var entities: Node = $Entities

## A list of spawns from the scene
## Spawns should be in the Spawns node
@onready var spawns: Node = $Entities/Spawns


## Gets a spawn by name
## If no name is given, get the Default spawn, or a random spawn
func get_spawn(spawn_name: String = '') -> Marker3D:
	assert( spawns.get_children().size() > 0, "No spawns found in level!")
	var spawn: Spawn = null

	if spawn_name == '':
		spawn = spawns.get_node("Default")
		assert(spawn is Marker3D)

		if spawn == null:
			return _choose_random_spawn()

		return spawn

	# Has the chance to return null!
	return spawns.get_node(spawn_name)


func _choose_random_spawn() -> Spawn:
	assert( spawns.get_children().size() > 0, "No spawns found in level!")

	# Modulus (%) is cool as fuck
	var spawn_index: int = randi() % spawns.get_children().size()
	return spawns.get_child(spawn_index)


## 
func _on_entities_tree_exiting() -> void:
	var children = entities.get_children()
	for i in range(entities.get_children().size()):
		if children[i].name == 'Player':
			entities.remove_child(children[i])
			
