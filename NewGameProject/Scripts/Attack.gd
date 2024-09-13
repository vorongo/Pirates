extends Area2D

class_name Attack

@export var character: CharacterBody2D

@export_group("attack settings")
@export var damage: float = 10.0
@export var reload_time: float = 1.0

signal attack_started
signal attack_ended

signal reload_ended

var is_reload: bool

func attack():
	emit_signal("attack_started")
	apply_damage_at_overlapping_enemies(character, damage, get_overlapping_bodies())
	emit_signal("attack_ended")

static func can_attack_body(body: Node, call_node: Node) -> bool:
	if body.is_in_group("characters") and body != call_node:
		return true
	return false

static func apply_damage_at_overlapping_enemies(call_node: Node, attack_damage: float, ovelapping_bodies: Array):
	for child in ovelapping_bodies:
		if can_attack_body(child, call_node):
			for node in child.get_children():
				if !node is HpNode:
					continue
				node.apply_damage(attack_damage)

func reload():
	is_reload = true
	await get_tree().create_timer(reload_time).timeout
	is_reload = false
	emit_signal("reload_ended")

func connect_infinite_attack():
	attack_ended.connect(reload)
	reload_ended.connect(attack)

func disconnect_infinite_attack():
	attack_ended.disconnect(reload)
	reload_ended.disconnect(attack)
