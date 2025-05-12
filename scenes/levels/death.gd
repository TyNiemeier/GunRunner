extends Node2D
var button_pressed = false


func _on_start_button_pressed():
	button_pressed = true
	get_tree().change_scene_to_file("res://scenes/levels/room_1.tscn")

func _on_quit_button_pressed():
	button_pressed = true
	get_tree().quit() 
