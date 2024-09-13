extends Area2D

class_name BaldPirateMovement

@export var character: CharacterBody2D

@export var speed: float = 200.0
@export var inaccuracy: Vector2 = Vector2(10.0, 0.0)

var start_position: Vector2

func _ready() -> void:
	start_position = character.global_position

func _process(delta: float) -> void:
	if get_direction_to_player() != Vector2.ZERO:
		character.velocity.x = get_move_path(get_direction_to_player().normalized()).x
	else:
		if !absf(character.global_position.x - start_position.x) <= inaccuracy.x:
			character.velocity.x = get_move_path(global_position.direction_to(start_position)).x
		else:
			character.velocity.x = 0.0
	character.move_and_slide()

func get_direction_to_player() -> Vector2:
	var direction_to_player: Vector2
	for body in get_overlapping_bodies():
		if body.is_in_group("player"):
			direction_to_player = character.global_position.direction_to(body.global_position)
	return direction_to_player

func get_move_path(direction: Vector2) -> Vector2:
	var move_direction: Vector2
	move_direction = direction * speed
	return move_direction
