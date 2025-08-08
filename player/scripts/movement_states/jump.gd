extends State

func update(delta : float) -> void:
	#Picking Speed Based on if Jumped while Sprinting
	if previous_state.name.to_lower() == "sprint":
		player.update_movement(player.speed_sprint, delta)
	else:
		player.update_movement(player.speed_default, delta)
	
	#If Player is Falling, Change to Falling State
	if player.velocity.y < -1.0 && !player.is_on_floor():
		state_machine.update_state("falling")

	#If Player is not Falling, Change to Idle State
	if player.is_on_floor():
		state_machine.update_state("idle")
