extends Node3D

@onready var animation_player:AnimationPlayer = $AnimationPlayer
func _ready():
	play_animation("Idle Pose", Animation.LOOP_PINGPONG)
	
func play_animation(animation_name: String, loop: Animation.LoopMode = Animation.LOOP_NONE):
	print("Playing animation ", animation_name)
	if animation_player.has_animation(animation_name):
		var animation: Animation = animation_player.get_animation(animation_name)

		if animation:
			animation.loop_mode = loop
			animation_player.play(animation_name)
		else:
			print("No animation for ... me") # Find out how to get node name
