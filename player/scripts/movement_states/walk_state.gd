extends State

var previous_state : State
func enter(_previous_state : State) -> void:
	CAM_ANIMATION.play("walk")
	previous_state = _previous_state

func physics_update(_delta : float) -> void:
	#If Player is Not Moving, Change to Idle State
	if player.velocity.length() == 0.0:
		state_machine.update_state("idle")
	
	#If Player Presses 'Sprint Button' While Walking
	if Input.is_action_pressed("sprint"):
		state_machine.update_state("sprint")
	
	#Player Walks at Walk Speed
	player.update_movement(player.speed_default, _delta)
