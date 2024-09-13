extends Area2D

class_name Bullet

@export var speed: float = 400.0

var direction: Vector2

var can_move: bool = true

func _process(delta: float) -> void:
	if can_move:
		global_position += delta * speed * direction

func set_move_mode(move: bool) -> void:
	can_move = move
