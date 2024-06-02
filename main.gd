extends Node

var score
@export var coin_scene: PackedScene # This lets us instantiate Coins dynamically.


func _ready():
	pass


func game_over():
	$CoinTimer.stop()
	$HUD.show_game_over()
	$Player.hide()
	get_tree().call_group("coins", "queue_free")


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()

	$HUD.update_score(score)
	$HUD.show_message("Get ready")
	$HUD/GameTimerLabel.show()

	$HUD.update_game_timer($GameTimer.wait_time)


func _on_start_timer_timeout():
	$GameTimer.start()
	$CoinTimer.start()


func _on_coin_timer_timeout():
	print("main: coin instantiated")
	var coin = coin_scene.instantiate()

	# Choose a random location on Path2D.
	var coin_spawn_location = $CoinPath/CoinSpawnLocation
	coin_spawn_location.progress_ratio = randf()

	coin.position = coin_spawn_location.position

	add_child(coin)

	$HUD.update_game_timer($GameTimer.time_left)


func _on_player_hit():
	score += 1
	$HUD.update_score(score)
