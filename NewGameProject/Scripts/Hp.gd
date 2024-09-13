extends Node

class_name HpNode

@export var hp: float = 100.0

signal damaged
signal died

func apply_damage(damage: float) -> void:
	hp -= damage
	damaged.emit()
	if check_death():
		death()

func check_death() -> bool:
	return hp <= 0

func death() -> void:
	died.emit()
