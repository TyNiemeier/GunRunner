extends Control
var button_pressed = false


func _on_start_button_pressed():
	button_pressed = true
	get_tree().change_scene_to_file("res://scenes/levels/main.tscn")
	
func _on_options_button_pressed():
	button_pressed = true
	get_tree().change_scene_to_file("res://Scenes/UI/settings.tscn") 

func _on_quit_button_pressed():
	button_pressed = true
	get_tree().quit() 
