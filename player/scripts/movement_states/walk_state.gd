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
	if Input.is_action_pressed("sprint") && player.is_on_floor():
		state_machine.update_state("sprint")
	
	#If Player is Falling, Change to Falling State
	if player.velocity.y < -3.0 && !player.is_on_floor():
		state_machine.update_state("falling")
	
	#Player Moves at Walk Speed
	player.update_movement(player.speed_default, _delta)
