extends Node
class_name Enum

# Describes a type of scene
# Not scene in the Godot sense, but more of "Are we loading a map, are we loading dialog?
enum SceneType {
	MAP,
	DIALOG
}

static var scene_type_names = {
	SceneType.DIALOG: "DIALOG",
	SceneType.MAP: "MAP",
}

static func scene_type_from_string(scene_type_string: String) -> SceneType:
	assert(scene_type_string is String, "INVALID SCENE_TYPE")
	match scene_type_string:
		"DIALOG":
			return SceneType.DIALOG
		"MAP":
			return SceneType.MAP
		_:
			print("INVALID SCENE TYPE [%s]" % scene_type_string)
			return SceneType.MAP

static func scene_type_to_string(scene_type: SceneType) -> String:
	assert(scene_type_names.has(scene_type), "INVALID SCENE TYPE! CANNOT CONVERT TO STRING!")
	return scene_type_names[scene_type] as String


enum MenuState {
	SAVE,
	JOURNAL
}
