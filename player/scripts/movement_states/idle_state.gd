extends State

func enter(previous_state : State) -> void:
	CAM_ANIMATION.pause()

func physics_update(_delta : float) -> void:
	#If Player is Moving, Change to Walk State
	if player.velocity.length() > 0.0 && player.is_on_floor():
		state_machine.update_state("walk")
	
	#Player "Moves"
	player.update_movement(player.speed_default, _delta)
