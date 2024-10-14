extends StaticBody3D

enum NpcLookBehavior {
	ALWAYS_AT_PLAYER,
	ROTATE_ON_INTERACT,
	NONE
}

@onready var animation_player = $blenderNode

## Which what is the name of the Dialogic timeline file to be used with
## dialoging with this character
@export var timeline_name: String = ""

## Should this NPC change directions
@export var looking_behavior: NpcLookBehavior = NpcLookBehavior.NONE

func _ready():
	print("The Animation player is", animation_player)
	animation_player.play_animation("idle", Animation.LOOP_PINGPONG)
	
func _process(delta: float) -> void:
	pass
	if GameService.player != null and looking_behavior == NpcLookBehavior.ALWAYS_AT_PLAYER:
		var player_pos = GameService.player.position
		look_at(Vector3(player_pos.x, position.y, player_pos.z))

func on_player_interact():
	if !timeline_name:
		print("This object has no dialog! Cannot interact", name)
		return		
	
	if looking_behavior == NpcLookBehavior.ROTATE_ON_INTERACT:
		var player_pos: Vector3 = GameService.player.position
		look_at(Vector3(player_pos.x, position.y, player_pos.z))
		
	DialogService.start_dialog(timeline_name)
