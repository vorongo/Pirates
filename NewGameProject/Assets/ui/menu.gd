extends Node2D

@export var next_scene: String # Сцена для кнопки Play

# Объявляем сигналы для остальных кнопок
signal options_button_pressed
signal levels_button_pressed
signal authors_button_pressed

# Функция, которая срабатывает при нажатии кнопки Play
func _on_play_button_pressed() -> void:
	# Переключение на сцену, указанную в переменной next_scene
	if next_scene != "":
		get_tree().change_scene_to_file(next_scene)

# Функция, которая срабатывает при нажатии кнопки Options
func _on_options_button_pressed() -> void:
	$".".visible == false
	emit_signal("options_button_pressed")
	# Здесь вызывается сигнал options_button_pressed

# Функция, которая срабатывает при нажатии кнопки Levels
func _on_levels_button_pressed() -> void:
	$".".visible == false
	emit_signal("levels_button_pressed")
	# Здесь вызывается сигнал levels_button_pressed

# Функция, которая срабатывает при нажатии кнопки Authors
func _on_authers_button_pressed() -> void:
	$".".visible == false
	emit_signal("authors_button_pressed")
	# Здесь вызывается сигнал authors_button_pressed

# Функция, которая срабатывает при нажатии кнопки Exit
func _on_exit_button_pressed() -> void:
	get_tree().quit() # Закрывает игру


func _on_options_options_close() -> void:
	if $".".visible == false:
		$".".visible = true
