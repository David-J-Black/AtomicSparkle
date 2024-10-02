extends Node

var FILE_LOCATION = "res://saves/"
var save_name: String = "save_file"

func load_save_file(file_name: String):
	if file_name == null:
		assert(save_name != null, "WHAT! The default save name is null!!")
		file_name = save_name

	var file_address = FILE_LOCATION + file_name + ".json"
	if not FileAccess.file_exists(file_address):
		print("Invalid save file")
		return
		
	var save_file = FileAccess.open(file_address, FileAccess.READ)
	var save_text: String = save_file.get_as_text()
	save_file.close()

	var parse_result = JSON.parse_string(save_text)

	if parse_result == null:
		print("INVALID SAVE")
		return

	# Add the save file name to this little baby
	parse_result["save_name"] = file_name

	# Populate a game scene information object
	var response := GameSceneInformation.new()

	# Convert the save from a Dictionary to a GameInformation whatever the fuck it's called
	response = _save_convert(parse_result, response)

	GameService.apply_save(response)
	save_name = file_name

	print("Finished loading save", JSON.stringify(parse_result, " "))
	
# Saves the game to a .json file of the local_save_name
func save_game(local_save_name: String) -> void:
	if local_save_name == null:
		local_save_name = save_name

	Dialogic.Save.save(local_save_name)
	
	# Grab the game informationn
	var game_state: Dictionary = GameService.get_state_dict()

	# Grab file
	var file_address = FILE_LOCATION + local_save_name + ".json"
	var file = FileAccess.open(file_address, FileAccess.WRITE)

	# Save that bitch!
	file.store_string(JSON.stringify(game_state, "   "))
	file.close()

	save_name = local_save_name

func new_save_file(file_name: String) -> void:
	var save: GameSceneInformation = GameSceneInformation.new()
	save.scene_name = "introduction"
	save.scene_type = Enum.SceneType.DIALOG
	save.map_events = {}
	save.conditionals = {}

	var file_path = FILE_LOCATION + file_name + ".json"

	if FileAccess.file_exists(file_path):
		print("FILE ALREADY EXISTS [%s]" % file_name)
		return

	var file = FileAccess.open(file_name, FileAccess.WRITE)
	var save_string = JSON.stringify(save, "	")


	file.store_string(save_string)
	save_name = file_name
	GameService.apply_save(save)

func get_save_names() -> Array[String]:
	print("You want to get save names?")
	var dir: DirAccess = DirAccess.open(FILE_LOCATION)
	
	# If no saves 🥺
	if dir == null:
		print("No saves...")
		return []
		
	# Start at beginning of file
	dir.list_dir_begin()
	var file_name = dir.get_next()
	
	var response: Array[String] = []
	
	# Keep iterating file names until we run out of file names
	while file_name != "":
		
		# wait... is this a file?
		if dir.current_is_dir() == false:
			# This is a file. Is it a json?
			if file_name.ends_with(".json"):
				response.append(file_name.split(".")[0])
		file_name = dir.get_next()
		
	print("Saves collected [%s]" % response)
	return response

# The saving part of the main menu
func open_save_menu():
	print("opening save menu...")
	var SaveMenu: Resource = load("res://scenes/menus/SaveMenu.tscn")
	var instance = SaveMenu.instantiate()
	get_tree().root.get_node("Main").add_child(instance)
	instance.visible = true
	instance.position = get_viewport().size / 2

# Convert the save json/Dict to an object
func _save_convert(dict: Dictionary, object: Object) -> GameSceneInformation:
	if dict == null:
		print("INVALID DICTIONARY! [%s]" % dict)
		return
		
	if object == null:
		print("INVALID OBJECT TO RECEIVE DICT INFORMATION [%s]" % object)
	
	var properties: Array = object.get_property_list()
	
	# For every entry in the save file
	for key in dict.keys():
		
		# For every property in a Game
		for property in properties:
			if property.name == key:
				var property_value = dict[key]
				
				# If one of the save properties is an enum, stick it in this match statement
				# The only enum we have RN is scene type lol
				match key:
					"scene_type":
						assert(property_value is String, "INVALID SCENE TYPE")
						property_value = Enum.scene_type_from_string(property_value)

				object.set(key, property_value)
	
	assert(object is GameSceneInformation, "INVALID SAVE FILE")
	return object
