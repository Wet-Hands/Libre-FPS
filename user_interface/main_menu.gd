extends Control

func _on_single_player_pressed() -> void:
	get_tree().change_scene_to_file("res://test_world.tscn")

func _on_exit_game_pressed() -> void:
	get_tree().quit()

func _on_host_game_pressed() -> void:
	$MultiplayerManager.become_host()
	$PanelContainer.hide()

func _on_join_game_pressed() -> void:
	#var level = test_world.instantiate()
	#self.add_child(level)_players_spawn_node = get_tree().
	$MultiplayerManager.join_as_client()
	$PanelContainer.hide()
