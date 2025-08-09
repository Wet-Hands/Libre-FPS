extends State

func enter(_previous_state : State) -> void:
	CAM_ANIMATION.pause()

func physics_update(_delta : float) -> void:
	#If Player is Moving, Change to Walk State
	if input_sync.velocity.length() > 0.0 && input_sync.on_floor:
		state_machine.update_state("walk")

	#If Player is Moving Up, Change to Jump State
	if input_sync.velocity.y > 0.0 && !input_sync.on_floor:
		state_machine.update_state("jump")

	#If Player is Falling, Change to Falling State
	if input_sync.velocity.y < -3.0 && !input_sync.on_floor:
		state_machine.update_state("falling")
	
	#Player "Moves"
	player.update_movement(player.speed_default, _delta)
