extends MultiplayerSynchronizer

#@export var player : CharacterBody3D
@export var movement_state_machine : StateMachine

var input_direction : Vector2
var camera_direction : Vector2
var head_transform : Transform3D

var velocity : Vector3
var on_floor : bool = false

func _ready() -> void:
	if get_multiplayer_authority() != multiplayer.get_unique_id():
		set_process(false)
		set_physics_process(false)
		movement_state_machine.set_process(false)
		movement_state_machine.set_physics_process(false)
	#input_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")

func _physics_process(_delta: float) -> void:
	input_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	head_transform = get_parent().head.transform
	
	velocity = get_parent().velocity
	$"../UI/DEBUG/VelocityLabel".text = str(velocity)
	on_floor = get_parent().is_on_floor()
	if Input.is_action_just_pressed("jump"):
		jump.rpc()

@rpc("call_local")
func jump() -> void:
	if multiplayer.is_server():
		get_parent().do_jump = true
