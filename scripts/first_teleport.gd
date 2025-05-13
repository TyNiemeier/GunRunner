extends Area2D

const FILE_BEGIN = "res://scenes/levels/room_"

var player_is_here = false

@export var level_to_load : int = -1

func _on_body_entered(body: Player):
	if body is Player:
		player_is_here = true
		
func _on_body_exited(body: Player):
	if body is Player:
		player_is_here = false
		
func _process(_delta):
	if player_is_here:
		if level_to_load < 0:
			print("You didn't tell me a level!")
		
		else:
			var next_level_number = level_to_load
		
			var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
			get_tree().change_scene_to_file(next_level_path)
