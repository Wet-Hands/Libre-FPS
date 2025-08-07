extends CharacterBody3D

#TODO List
#Rewrite Camera Control
#DECIDE BASIC ASPECTS OF THE GAME (Such as the Visual Style, Multiplayer Structure, and the FUCKING NAME)
#Complete MovementStateMachine

#Movement Variables
@export_category("Movement")
@export var speed_default : float = 5.0
@export var speed_sprint : float = 6.5
@export var acceleration : float = 0.1
@export var deceleration : float = 0.25
@export var jump_velocity : float = 4.5
@export var gravity : float = 9.81

#Camera Variables
@export_category("Camera")
@export var camera_sensitivity : float = 0.25
@export var tilt_upper_limit : float = 90.0
@export var tilt_lower_limit : float = -90.0

#Control Variables
var input_direction

@export_category("Node Declarations")
@export var head : Node3D
@export var cam : Camera3D
@export var ray : RayCast3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	update_camera(event)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()

func update_camera(event : InputEvent) -> void:
	if event is InputEventMouseMotion: #If mouse is moving
		head.rotate_y(-event.relative.x * camera_sensitivity * get_process_delta_time()) #Look left and right
		cam.rotate_x(-event.relative.y * camera_sensitivity * get_process_delta_time()) #Look up and down
		cam.rotation.x = clamp(cam.rotation.x, deg_to_rad(tilt_lower_limit), deg_to_rad(tilt_upper_limit)) #Stop turning so player's neck doesn't break
		cam.rotation.y = 0
		cam.rotation.z = 0
		if cam.rotation.x <= tilt_lower_limit || cam.rotation.x >= tilt_upper_limit:
			cam.rotation.x = 0

func update_movement(speed : float, delta : float):
	if !is_on_floor():
		velocity.y -= gravity * delta
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = jump_velocity
	
	input_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (head.transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()
	if direction:
		velocity.x = lerp(velocity.x, direction.x * speed, acceleration)
		velocity.z = lerp(velocity.z, direction.z * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.z = move_toward(velocity.z, 0, deceleration)
	
	move_and_slide()
