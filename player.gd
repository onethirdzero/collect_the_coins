extends Area2D

@export var max_speed = 800
@export var acceleration = 500 # Units per frame.
@export var turn_deceleration = 600 # Units per frame.
@export var rotation_speed = 500

var current_speed = 0
var moving # Used to signal to this node that a game has started.
var screen_size

signal hit


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	moving = false
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if current_speed < max_speed and moving:
		current_speed += acceleration * delta

	# Change rotation based on input.
	if Input.is_action_pressed("move_right"):
		global_rotation_degrees += rotation_speed * delta
		current_speed = max(0, current_speed - turn_deceleration * delta)
	if Input.is_action_pressed("move_left"):
		global_rotation_degrees -= rotation_speed * delta
		current_speed = max(0, current_speed - turn_deceleration * delta)

	velocity = Vector2(0, -1).rotated(global_rotation) * current_speed

	position += velocity * delta

	# Prevent player from moving off screen.
	position = position.clamp(Vector2.ZERO, screen_size)


func start(pos):
	position = pos
	show()
	moving = true
	current_speed = 0


func _on_body_entered(body):
	hit.emit()
	if body is RigidBody2D:
		body.queue_free()
