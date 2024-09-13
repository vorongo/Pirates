extends Node2D


#первая версия
func _on_button_mouse_entered() -> void:
	$AnimationPlayer.play("_on_button_mouse_entered")



func _on_button_mouse_exited() -> void:
	$AnimationPlayer.play("on_button_mouse_exited")


func _on_exit_button_pressed() -> void:
	$AudioStreamPlayer.play()
	# Дождитесь, пока звук не закончится
	await $AudioStreamPlayer.finished
	# Переходите к новой сцене
	get_tree().quit()
