extends CanvasLayer


func _process(_delta):
	pass


func _on_player_health_change(health):
	$Health.value = health
	
func _on_player_weapon_changed(currentWeapon):
	if currentWeapon == 0:
		$SpearEnabled.visible = true
		$GunEnabled.visible = false
	elif currentWeapon == 1:
		$SpearEnabled.visible = false
		$GunEnabled.visible = true

func _on_player_bombtime_active(active):
	if active == 0:
		$BombTimer.value = 0
	elif active == 100:
		$BombTimer.value = 100
