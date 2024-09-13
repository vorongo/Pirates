extends AnimatedSprite2D

class_name CharacterAnimation

@export var character: CharacterBody2D
@export var attack: Attack
@export var hp_node: HpNode

@export var initial_flip_h: bool = false

@export_group("animations name")
@export var jump_animation_name: String = "Jump"
@export var fall_animation_name: String = "Fall"
@export var hit_animation_name: String = "Hit"
@export var idle_animation_name: String = "Idle"
@export var run_animation_name: String = "Run"
@export var attack_animation_name: String = "Attack"

var is_playing_priority_animation: bool = false

func _ready() -> void:
	# Подключаем анимации к сигналам
	attack.attack_started.connect(play_attack_animation)
	hp_node.damaged.connect(play_hit_animation)

func _process(delta: float) -> void:
	if not is_playing_priority_animation: # Только если нет приоритетной анимации
		play_movement_animation()

func play_movement_animation() -> void:
	if character.velocity != Vector2.ZERO:
		play(run_animation_name)
		if character.velocity.x > 0.0:
			if initial_flip_h:
				flip_h = true
			else:
				flip_h = false
		else:
			if initial_flip_h:
				flip_h = false
			else:
				flip_h = true
	else:
		play(idle_animation_name)

	if not character.is_on_floor():
		play(fall_animation_name)

func play_hit_animation() -> void:
	is_playing_priority_animation = true
	play(hit_animation_name)
	await animation_finished
	is_playing_priority_animation = false

func play_attack_animation() -> void:
	is_playing_priority_animation = true
	play(attack_animation_name)
	await animation_finished
	is_playing_priority_animation = false
