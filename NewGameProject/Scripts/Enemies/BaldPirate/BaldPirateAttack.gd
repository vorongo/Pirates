extends Attack

class_name BaldPirateAttack

func _on_body_entered(body: Node2D) -> void:
	if can_attack_body(body, character):
		if !is_connected("attack_ended", reload) and !is_connected("reload_ended", attack):
			connect_infinite_attack()
			attack()


func _on_body_exited(body: Node2D) -> void:
	disconnect_infinite_attack()
