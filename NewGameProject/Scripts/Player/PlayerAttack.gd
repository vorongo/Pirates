extends Attack

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack") and event.is_pressed():
		if !is_reload:
			attack()
