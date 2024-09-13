extends Node

class_name BulletDamageApplier

@export var bullet: Bullet
@export var bullet_damage: BulletDamage
@onready var cannon_ball_animation: AnimatedSprite2D = $"../CannonBallAnimation"

func _ready() -> void:
	bullet.body_entered.connect(_on_bullet_entered)

func _on_bullet_entered(body: Node2D) -> void:
	if body is RayCast2D or body.is_in_group("enemies"):
		return
	if body.is_in_group("player"):
		Attack.apply_damage_at_overlapping_enemies(bullet, bullet_damage.damage, bullet.get_overlapping_bodies())
	bullet.set_move_mode(false)
	cannon_ball_animation.play("Explosition")
	await cannon_ball_animation.animation_finished
	bullet.queue_free()
