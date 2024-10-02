extends Node
class_name GameState

var scene_name: String = ""
var scene_type: Enum.SceneType = Enum.SceneType.MAP

# A dictionary containing events that trigger upon loading the map with the given key name
# @key: map name
# @value: Array of events to be played after loading the map
var map_events: Dictionary = {}

# I would say... just put bools in here. You can store integers
# I imagine this class being like "has_visited_stacy": true
var conditionals: Dictionary = {}
