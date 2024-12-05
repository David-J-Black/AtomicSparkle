extends Node

var _scene_info: GameSceneInformation

## The player!
## Impossible for this to be null? This might change in the future
var player: Player

# This should only be called by the save service
func apply_save(save_state: GameSceneInformation):
	_scene_info = save_state
	# Blow up any running dialog scenes
	#DialogService.stop_dialog()
	MenuService.set_visible(false)

	# Load scene
	print("Scene type we are applying [%s]" % save_state.scene_type)
	match(save_state.scene_type):
		Enum.SceneType.MAP:
			DialogService.stop_dialog()
			#MapService.load_map(save_state.scene_name)
		Enum.SceneType.DIALOG:
			print("Going to load dialog [%s]" % save_state.save_name)
			DialogService.start_dialog(save_state.scene_name)
		_:
			assert("INVALID SCENE TYPE [%s]" % save_state.scene_type) 
	
# Grabe the entire "current state" of the game
# Including, what time it is, where the user currently is
func get_state() -> GameSceneInformation:
	return _scene_info
	
func get_state_dict() -> Dictionary:
	var response: Dictionary = {}
	
	response["scene_name"] = _scene_info.scene_name
	response["scene_type"] = Enum.scene_type_to_string(_scene_info.scene_type)
	response["map_events"] = _scene_info.map_events
	response["conditionals"] = _scene_info.conditionals
	# TODO: Add map events and conditionals
	
	return response

# load up the events that occur upon a map getting loaded
func get_map_events(map_name: String) -> Array[MapEvent]:
	return _scene_info.map_events[map_name]

func set_scene_info(scene_name: String, scene_type: Enum.SceneType):
	assert(scene_name != null or scene_name != '', "INVALID SCENE NAME")
	assert(scene_type != null, "INVALID SCENE TYPE")
	self._scene_info.scene_name = scene_name
	self._scene_info.scene_type = scene_type

func get_scene_name() -> String:
	return _scene_info.scene_name
	
func set_scene(scene_name: String, scene_type: Enum.SceneType) -> void:
	assert(scene_name != null, "NO SCENE NAME GIVEN")
	assert(scene_type != null, "NO SCENE TYPE GIVEN")
	assert(_scene_info != null, "What? Where is the scene information? Is a scene loaded?")
	_scene_info.scene_name = scene_name
	_scene_info.scene_type = scene_type

func end_game():
	get_tree().quit()
