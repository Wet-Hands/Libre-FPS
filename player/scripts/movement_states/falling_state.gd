extends State

func update(delta : float) -> void:
	player.update_movement(player.speed_default, delta)
	
	if player.is_on_floor():
		state_machine.update_state("idle")
