extends State

func update(delta : float) -> void:
	if previous_state.name.to_lower() == "sprint":
		player.update_movement(player.speed_sprint, delta)
	else:
		player.update_movement(player.speed_default, delta)
	
	#If Player is not Falling, Change to Idle State
	if input_sync.on_floor:
		state_machine.update_state("idle")
