extends State

@export var walk_anim_speed : float = 1.0

func enter(_previous_state : State) -> void:
	CAM_ANIMATION.play("walk")
	CAM_ANIMATION.speed_scale = walk_anim_speed
	print("WALK")
	$"../../UsernameLabel".text = "Walk"

func physics_update(_delta : float) -> void:
	#If Player is Not Moving, Change to Idle State
	if input_sync.velocity.length() == 0.0:
		state_machine.update_state("idle")
	
	#If Player Presses 'Sprint Button' While Walking
	if Input.is_action_pressed("sprint") && input_sync.on_floor:
		state_machine.update_state("sprint")
	
	#If Player is Moving Up, Change to Jump State
	if input_sync.velocity.y > 0.0 && !input_sync.on_floor:
		state_machine.update_state("jump")

	#If Player is Falling, Change to Falling State
	if input_sync.velocity.y < -3.0 && !input_sync.on_floor:
		state_machine.update_state("falling")
	
	#Player Moves at Walk Speed
	player.update_movement(player.speed_default, _delta)
