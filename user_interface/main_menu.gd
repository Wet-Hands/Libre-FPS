extends Control

@onready var test_world := load("res://test_world.tscn")

func _on_single_player_pressed() -> void:
	get_tree().change_scene_to_file("res://test_world.tscn")

func _on_exit_game_pressed() -> void:
	get_tree().quit()
