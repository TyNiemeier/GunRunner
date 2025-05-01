extends AnimatedSprite2D


func _on_frame_changed() -> void:
	if animation == "Attacking":
		if frame == 2 or frame == 9:
			get_parent().attack(1)
	if animation == "Skill1":
		if frame == 6 or 7 or 8:
			get_parent().attack(1)
