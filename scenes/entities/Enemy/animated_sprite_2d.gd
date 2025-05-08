extends AnimatedSprite2D


var spirits = preload("res://scenes/entities/Enemy/summons.tscn")

func _on_frame_changed() -> void:
	if animation == "Attacking":
		if frame == 2 or frame == 9:
			get_parent().attack(15)
	if animation == "Skill1":
		if frame == 6:
			get_parent().attack(20)
	if animation == "Summoning":
		if frame == 2:
			var spirit = spirits.instantiate()
			var spirit2 = spirits.instantiate()
			var spirit3 = spirits.instantiate()
			get_parent().add_child(spirit)
			get_parent().add_child(spirit2)
			get_parent().add_child(spirit3)
			spirit.global_position = $"../Marker2D".global_position
			spirit2.global_position = $"../Marker2D2".global_position
			spirit3.global_position = $"../Marker2D3".global_position
