extends Control
var button_pressed = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("p1_start"):
		button_pressed = true
		get_tree().change_scene_to_file("res://scenes/levels/room_1.tscn")

func _on_options_button_pressed():
	button_pressed = true
	get_tree().change_scene_to_file("res://Scenes/UI/options.tscn")

func _on_quit_button_pressed():
	button_pressed = true
	get_tree().quit()
