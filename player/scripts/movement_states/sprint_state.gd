extends State

@export var walk_anim_speed : float = 1.5

func enter(previous_state : State) -> void:
	CAM_ANIMATION.speed_scale = walk_anim_speed

func physics_update(_delta : float) -> void:
	#If Player is Not Moving, Change to Idle State
	if player.velocity.length() == 0.0:
		state_machine.update_state("idle")
	
	#If Player Presses 'Sprint Button' While Walking
	if Input.is_action_just_released("sprint"):
		state_machine.update_state("walk")
	
	#Player Walks at Sprint Speed
	player.update_movement(player.speed_sprint, _delta)
