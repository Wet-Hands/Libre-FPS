extends State

func physics_update(_delta : float) -> void:
	if player.velocity.length() == 0.0:
		state_machine.update_state("idle")
