extends Node

class_name PlayerMovement

@export var player: CharacterBody2D

@export_group("move settings")
@export var speed: float = 300.0
@export var jump_velocity: float = -1000.0
@export var gravity: float = 2000.0

func _physics_process(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		player.velocity.y = jump_velocity

	var direction := Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * speed
	else:
		player.velocity.x = 0.0

	player.move_and_slide()
