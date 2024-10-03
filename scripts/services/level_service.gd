extends Node
## The singleton in charge of all level functions
@onready var Player = preload("res://scenes/player.tscn")

## The current level
var level: GameLevel = null
var level_name: String = ''

# The parent node of the levels we load
var level_anchor: Node3D = null

## Give us relevant entities from main.tscn
func setup(level_anchor: Node3D):
	self.level_anchor = level_anchor

	# Loads the default level (first_level)
	load_level()
	spawn_player()


## Load's a level from the /levels folder.
## If no level name is given, we load firrst_level
func load_level(level_name: String = '') -> void :

	# No level given? We're goint to load the first level
	if level_name == '':
		level_name = "first_level"

	# Setup the file name
	var file_name = "res://levels/" + level_name + ".tscn"
	var new_level_scene: PackedScene = load(file_name)
	assert(new_level_scene != null, "Invalid level name [%s]" % level_name)
	var new_level = new_level_scene.instantiate()
	assert(new_level != null && new_level is GameLevel, "Invalid game level!")
	self.level_name = level_name

	# After loading level, check it is valid then attatch it to main scene
	assert( new_level != null, "Invalid level! [%s]" % level_name)
	level = new_level
	level_anchor.add_child(level)

## Loads the player at a spawn
## If no spawn is given, If we look for a spawn named default
## If default doesn't exist, a random spawn
func spawn_player(spawn_name: String = ''):
	assert(level != null, "No level anchor, cannot spawn_player")
	var spawn = level.get_spawn(spawn_name)

	var player = GameService.player

	level.entities.add_child(player)
	player.position = spawn.position
	print("Spawned player spawn_name [%s] position [%s]" % [spawn_name, player.position])
