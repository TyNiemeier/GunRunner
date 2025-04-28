extends Area2D
class_name Hitbox
	
func take_damage():
	get_parent().take_damage()
