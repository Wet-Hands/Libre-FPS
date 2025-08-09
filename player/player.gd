extends CharacterBody3D

#TODO List
#Rewrite Camera Control
#DECIDE BASIC ASPECTS OF THE GAME (Such as the Visual Style, Multiplayer Structure, and the FUCKING NAME)
#Complete MovementStateMachine

#Movement Variables
@export_category("Movement")
@export var speed_default : float = 5.0
@export var speed_sprint : float = 6.5
@export var speed_crouch : float = 3.5
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
var input_direction : Vector2
var mouse_input : Vector2
var input_rotation : Vector3
var do_jump : bool = false

@export_category("Node Declarations")
@export var head : Node3D
@export var cam : Camera3D
@export var ray : RayCast3D
@export var cam_anchor : Marker3D

#Multiplayer Player Data
@export_category("Multiplayer")
@export var player_id : int = 1:
	set(id):
		player_id = id
		input_sync.set_multiplayer_authority(id)
@export var username : String = "{USERNAME}"
@export var input_sync : MultiplayerSynchronizer

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Engine.max_fps = 120
	$UsernameLabel.text = str(player_id)
	if multiplayer.get_unique_id() == player_id:
		cam.make_current()
		$UI/DEBUG.show()
		$UI.show()
	else:
		$UI/DEBUG.hide()
		$UI.hide()

func _input(event: InputEvent) -> void:
	update_camera(event)

func _process(_delta: float) -> void:
	$UI/DEBUG/FPSLabel.text = str(Engine.get_frames_per_second())
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

func bad_update_camera(event : InputEvent) -> void:
	if event is InputEventMouseMotion: #If mouse is moving
		mouse_input.x += -event.screen_relative.x * camera_sensitivity
		mouse_input.y += -event.screen_relative.y * camera_sensitivity
	input_rotation.x = clampf(input_rotation.x + mouse_input.y, deg_to_rad(tilt_lower_limit), deg_to_rad(tilt_upper_limit))
	input_rotation.y += mouse_input.x
	
	cam_anchor.transform.basis = Basis.from_euler(Vector3(input_rotation.x, 0.0, 0.0))
	self.global_transform.basis = Basis.from_euler(Vector3(0.0, input_rotation.y, 0.0))
	
	cam.global_transform = cam_anchor.get_global_transform_interpolated()
	mouse_input = Vector2.ZERO

func update_movement(speed : float, delta : float):
	#if !is_multiplayer_authority(): return
	#if $InputSynchronizer.get_multiplayer_authority() != multiplayer.get_unique_id(): return
	if !multiplayer.is_server(): return

	if !input_sync.on_floor:
		velocity.y -= gravity * delta

	if do_jump == true:
		if input_sync.on_floor:
			velocity.y = jump_velocity
		do_jump = false
	
	input_direction = input_sync.input_direction
	var direction = (input_sync.head_transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()
	if multiplayer.get_unique_id() != 1:
		print(str(direction) + " " + str(multiplayer.get_unique_id()))
	if direction:
		velocity.x = lerp(velocity.x, direction.x * speed, acceleration)
		velocity.z = lerp(velocity.z, direction.z * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.z = move_toward(velocity.z, 0, deceleration)
	
	move_and_slide()
