class_name State extends Node

@onready var player = self.get_parent().get_parent() #Currently the worst line of code
var state_machine : StateMachine

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta : float) -> void:
	pass

func physics_update(_delta : float) -> void:
	pass
