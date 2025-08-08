extends Control

@export var multiplayer_manager : Node
@export var menu : PanelContainer

func _on_single_player_pressed() -> void:
	get_tree().change_scene_to_file("res://test_world.tscn")

func _on_exit_game_pressed() -> void:
	get_tree().quit()

func _on_host_game_pressed() -> void:
	multiplayer_manager.become_host()
	menu.hide()

func _on_join_game_pressed() -> void:
	multiplayer_manager.join_as_client()
	menu.hide()
