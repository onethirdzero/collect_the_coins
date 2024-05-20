extends Node

var score
@export var coin_scene: PackedScene # This lets us instantiate Coins dynamically.


func _ready():
	pass

func game_over():
	$CoinTimer.stop()
	
	print("GAME OVER")
	# TODO: Display game over message.


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
	# TODO: Clear previous coins.


func _on_start_timer_timeout():
	$GameTimer.start()
	$CoinTimer.start()


func _on_coin_timer_timeout():
	print("instantiate coin")
	var coin = coin_scene.instantiate()
	
	# Choose a random location on Path2D.
	var coin_spawn_location = $CoinPath/CoinSpawnLocation
	coin_spawn_location.progress_ratio = randf()

	coin.position = coin_spawn_location.position
	
	add_child(coin)


func _on_player_hit():
	score += 1
	print("main: score: %d" % score)
