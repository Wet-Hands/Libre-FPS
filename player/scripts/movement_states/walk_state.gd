extends State

@export var walk_anim_speed : float = 1.0

func enter(_previous_state : State) -> void:
	CAM_ANIMATION.play("walk")
	CAM_ANIMATION.speed_scale = walk_anim_speed

func physics_update(_delta : float) -> void:
	#If Player is Not Moving, Change to Idle State
	if player.velocity.length() == 0.0:
		state_machine.update_state("idle")
	
	#If Player Presses 'Sprint Button' While Walking
	if Input.is_action_pressed("sprint"):
		state_machine.update_state("sprint")
	
	#Player Walks at Walk Speed
	player.update_movement(player.speed_default, _delta)
