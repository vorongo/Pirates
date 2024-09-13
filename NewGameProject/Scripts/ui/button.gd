extends Node2D


#первая версия
func _on_button_mouse_entered() -> void:
	$AnimationPlayer.play("_on_button_mouse_entered")



func _on_button_mouse_exited() -> void:
	$AnimationPlayer.play("on_button_mouse_exited")
