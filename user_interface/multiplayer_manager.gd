extends Node

@onready var test_world := load("res://test_world.tscn")

@onready var player_scene := load("res://player/player.tscn")
var _players_spawn_node : Node

const SERVER_PORT : int = 8910
var SERVER_IP : String = "127.0.0.1"

func become_host() -> void:
	_players_spawn_node = $"../Players" #Fix this
	
	var server_peer : ENetMultiplayerPeer = ENetMultiplayerPeer.new()
	server_peer.create_server(SERVER_PORT)
	
	multiplayer.multiplayer_peer = server_peer
	
	multiplayer.peer_connected.connect(_add_player_to_game)
	multiplayer.peer_disconnected.connect(_delete_player)
	
	var level = test_world.instantiate()
	self.add_child(level)
	
	_add_player_to_game(1)

func join_as_client() -> void:
	var client_peer : ENetMultiplayerPeer = ENetMultiplayerPeer.new()
	client_peer.create_client(SERVER_IP, SERVER_PORT)
	
	multiplayer.multiplayer_peer = client_peer
	
	var level = test_world.instantiate()
	self.add_child(level)

func _add_player_to_game(id : int) -> void:
	print("Player %s joined the game!" % id)
	
	var player_to_add = player_scene.instantiate()
	player_to_add.player_id = id
	player_to_add.name = str(id)
	player_to_add.username = "{USERNAME}"
	
	player_to_add.position.x = randi_range(-5, 5)
	player_to_add.position.y = 2
	player_to_add.position.z = randi_range(-5, 5)
	
	_players_spawn_node.add_child(player_to_add, true)

func _delete_player(id : int) -> void:
	print("Player %s left the game!" % id)
	if !_players_spawn_node.has_node(str(id)):
		return
	_players_spawn_node.get_node(str(id)).queue_free()
