extends Node

var xr_player: XRPlayer
var xr_enabled: bool = _is_xr_enabled()

## Hand to use for movement (This name should be changed
@export var character_control_hand: XRPlayer.Hand = XRPlayer.Hand.LEFT

## Get the player input for the left controller
func get_controller(hand: XRPlayer.Hand) -> XRController3D:
	
	# Null check motherfucker
	if xr_player == null:
		return null
	
	return xr_player.get_xr_hand(hand)

# This is all stretched out for debbugging purposes
func _is_xr_enabled() -> bool:
	var open_xr = XRServer.find_interface("OpenXR")
	var response = open_xr.is_initialized()
	return response
