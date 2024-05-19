extends Area2D

@export var speed = 400
var screen_size
signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
# TODO: Add self-acceleration.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x = 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	
	if velocity.length() > 0:
		# If more than 1 input direction is detected, the resulting
		# vector has a higher speed than when only 1 input is detected.
		# Avoid this by normalizing the resulting vector.
		velocity = velocity.normalized() * speed

	position += velocity * delta
	
	# Prevent player from moving off screen.
	position = position.clamp(Vector2.ZERO, screen_size)

func start(pos):
	position = pos
	show()


func _on_body_entered(body):
	hit.emit()
	if body is RigidBody2D:
		body.queue_free()
