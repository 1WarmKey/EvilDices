extends Node2D


func _on_texture_button_pressed() -> void:
	var mainScene =  load("res://Scens/game.tscn")
	get_tree().change_scene_to_packed(mainScene)
