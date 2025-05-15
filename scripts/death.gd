extends Node2D

func _physics_process(delta):
	if Input.is_action_just_pressed("p1_start"):
		get_tree().change_scene_to_file("res://scenes/levels/room_1.tscn")
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
