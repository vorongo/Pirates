extends Node2D

signal options_close
@onready var options_button = $OptionButton as OptionButton
@onready var sound_button = $SoundButton as TextureButton  # TextureButton вместо Button
@onready var h_slider = $HSlider as HSlider  # Проверьте путь к слайдеру

const RESOLUTION_DICTIONARY: Dictionary = {
	"1920 x 1080": Vector2i(1920, 1080),
	"1280 x 720": Vector2i(1280, 720)
}

# Переменные для отслеживания состояния звука
var is_muted: bool = false

func _ready() -> void:
	options_button.item_selected.connect(on_resolution_selected)
	# Подключение слайдера к изменению громкости
	h_slider.value_changed.connect(_on_h_slider_value_changed)

# Переключение громкости и изменение текстур кнопки
func _on_sound_button_pressed() -> void:
	is_muted = !is_muted
	if is_muted:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
		# Смена текстур для состояния "звук выключен"
		_change_button_textures("res://Assets/ui/sound_button_off_normal.png", 
								"res://Assets/ui/sound_button_off_hover.png", 
								"res://Assets/ui/sound_button_off_pressed.png")
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
		# Смена текстур для состояния "звук включен"
		_change_button_textures("res://Assets/ui/sound_button_on_normal.png", 
								"res://Assets/ui/sound_button_on_hover.png", 
								"res://Assets/ui/sound_button_on_pressed.png")

# Функция для смены текстур кнопки (TextureButton)
func _change_button_textures(normal_texture: String, hover_texture: String, pressed_texture: String) -> void:
	sound_button.texture_normal = load(normal_texture)
	sound_button.texture_hover = load(hover_texture)
	sound_button.texture_pressed = load(pressed_texture)

# Изменение громкости через слайдер
func _on_h_slider_value_changed(value: float) -> void:
	# Установка громкости через слайдер (значение слайдера от -80 до 0 дБ)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)

# Открытие меню
func _on_menu_options_button_pressed() -> void:
	$".".visible = true

# Выбор разрешения
func on_resolution_selected(index: int) -> void:
	DisplayServer.window_set_size(RESOLUTION_DICTIONARY.values()[index])

# Закрытие меню
func _on_close_pressed() -> void:
	emit_signal("options_close")
	$".".visible = false
