extends Enemy

func shoot_fireball():
	pass

func shoot_cooldown():
	pass


func _on_fireball_range_body_entered(body):
	if body is Player:
		in_range = true


func _on_fireball_range_body_exited(body):
	if body is Player:
		in_range = false
