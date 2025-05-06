extends Area2D
class_name Hitbox
	
func take_damage(amount):
	get_parent().take_damage(amount)
