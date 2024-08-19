extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	connect
	pass # Replace with function body.
	
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed('interact'):
		
		# Get all the entities interlapping with us...
		var overlapping_bodies: Array[Node3D] = get_overlapping_bodies()
		
		for body in overlapping_bodies:
			print('You are interacting with ', body.name)
