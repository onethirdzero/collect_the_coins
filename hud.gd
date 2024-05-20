extends CanvasLayer

# Notify Main scene that the game has started.
signal start_game


func _ready():
	$GameTimerLabel.hide()


func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Game Over")
	await $MessageTimer.timeout

	# No need to time out this message because this is the title text.
	$Message.text = "Collect The Coins"
	$Message.show()
	
	# Add a slight delay before showing the start button.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()


func update_score(score):
	$ScoreLabel.text = str(score)


func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()


func _on_message_timer_timeout():
	$Message.hide()

func update_game_timer(time_left):
	$GameTimerLabel.text = "Time left: %s" % str(int(time_left))
