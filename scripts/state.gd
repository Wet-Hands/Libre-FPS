class_name State extends Node

@onready var player : CharacterBody3D = self.get_parent().get_parent() #Currently the worst line of code
@onready var CAM_ANIMATION : AnimationPlayer = $"../CamAnimPlayer"

var state_machine : StateMachine
var previous_state : State

func enter(_previous_state : State) -> void:
	previous_state = _previous_state

func exit() -> void:
	pass

func update(_delta : float) -> void:
	pass

func physics_update(_delta : float) -> void:
	pass
