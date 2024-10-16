extends Node3D
class_name CharacterModel

@onready var animation_player:AnimationPlayer = $AnimationPlayer

func _ready():
	play_animation("Idle Pose", Animation.LOOP_PINGPONG)
	
func play_animation(animation_name: String, loop: Animation.LoopMode = Animation.LOOP_NONE, custom_blend: float = -1):
	if animation_player.has_animation(animation_name):
		var animation: Animation = animation_player.get_animation(animation_name)

		if animation:
			animation.loop_mode = loop
			animation_player.play(animation_name, custom_blend)
		else:
			printerr("No animation for ... [%s]" % name) # Find out how to get node name
