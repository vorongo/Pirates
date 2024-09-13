extends Attack

class_name CannonAttack

@export var raycast: RayCast2D
@export var marker: Marker2D

@export_group("bullet settings")
@export var bullet_scene: PackedScene = preload("res://Scenes/Bullet.tscn")

func _ready() -> void:
	connect_infinite_attack()
	reload()

func attack() -> void:
	emit_signal("attack_started")
	var bullet_instance: Bullet = bullet_scene.instantiate()
	bullet_instance.global_position = marker.global_position
	bullet_instance.direction = bullet_instance.global_position.direction_to(raycast.target_position + raycast.global_position)
	set_damage_to_bullet(bullet_instance)
	get_tree().current_scene.add_child(bullet_instance)
	emit_signal("attack_ended")

func set_damage_to_bullet(bullet: Bullet) -> void:
	for child in bullet.get_children():
		if child is BulletDamage:
			child.damage = damage
