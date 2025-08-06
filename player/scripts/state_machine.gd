class_name StateMachine extends Node

@export var initial_state : State

var current_state : State
var states : Dictionary[String, State] = {}

func _ready() -> void:
	#Fills the Dictionary with all States & Tells States their StateMachine
	for child in get_children():
		if child is State:
			child.state_machine = self
			states[child.name.to_lower()] = child
	#If Initial State Declared, Enter the Initial State
	if initial_state:
		initial_state.enter(initial_state)
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)
		$"../UI/DEBUG/MovementStateLabel".text = str(current_state) #Second Worst Line of Code

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func update_state(new_state_name : String):
	var new_state : State = states.get(new_state_name.to_lower())
	assert(new_state, "State Not Found: " + new_state_name)
	
	if current_state:
		current_state.exit()
	new_state.enter(current_state)
	current_state = new_state
