extends Control

# Start Game
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/level.tscn")

# Quit Game
func _on_quit_button_pressed():
	get_tree().quit()
