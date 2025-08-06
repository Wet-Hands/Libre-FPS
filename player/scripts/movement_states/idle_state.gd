extends State

func physics_update(_delta : float) -> void:
	if player.velocity.length() > 0.0 && player.is_on_floor():
		state_machine.update_state("walk")
