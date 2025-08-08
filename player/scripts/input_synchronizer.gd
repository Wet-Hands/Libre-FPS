extends MultiplayerSynchronizer

@export var player : CharacterBody3D

var input_direction : Vector2
var camera_direction : Vector2
var head_transform : Transform3D

func _ready() -> void:
	if get_multiplayer_authority() != multiplayer.get_unique_id():
		set_process(false)
		set_physics_process(false)
	input_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")

func _physics_process(delta: float) -> void:
	input_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	head_transform = player.head.transform
	if Input.is_action_just_pressed("jump"):
		jump.rpc()

@rpc("call_local")
func jump() -> void:
	if multiplayer.is_server():
		player.do_jump = true
