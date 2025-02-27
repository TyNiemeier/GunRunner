extends CharacterBody2D
class_name player


@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@export var playerId : int = 0
enum Directions {UP, DOWN, LEFT, RIGHT}
var facing : Directions = Directions.DOWN
var direction: Vector2 = Vector2.ZERO
var isSprinting = false
var SPEED: int = 150
var currentWeapon = 0
var isAttacking = false
var isIdle = false
#updates facing based on the direction
#used for animations 
func _set_direction():
	if direction.x < 0:
		facing = Directions.LEFT
	elif direction.x > 0:
		facing = Directions.RIGHT
	elif direction.y > 0:
		facing = Directions.DOWN
	elif direction.y < 0:
		facing = Directions.UP
	if direction.x == 0 && direction.y == 0:
		isIdle = true
	else:
		isIdle = false
#sets animations for sprinting idle walk dash, etc
func _set_animation():
	#changes sprinting 
	if isSprinting:
		#sprinting for spear
		if currentWeapon == 0:
			if facing == Directions.LEFT:
				sprite.play("p1_spearRunDownLeft")
			elif facing == Directions.RIGHT:
				sprite.play("p1_spearRunDownRight")
			elif facing == Directions.DOWN:
				sprite.play("p1_spearRunDown")
			elif facing == Directions.UP:
				sprite.play("p1_spearRunUp")
		#sprinting for gun
		else:
			if facing == Directions.LEFT:
				sprite.play("p1_gunRunDownLeft")
			elif facing == Directions.RIGHT:
				sprite.play("p1_gunRunDownRight")
			elif facing == Directions.DOWN:
				sprite.play("p1_gunRunDown")
			elif facing == Directions.UP:
				sprite.play("p1_gunRunUp")


	#changes idle animations
	elif isIdle:
		#idle for spear
		if currentWeapon == 0:
			if facing == Directions.LEFT:
				sprite.play("p1_idleSpearDownLeft")
			elif facing == Directions.RIGHT:
				sprite.play("p1_idleSpearDownRight")
			elif facing == Directions.DOWN:
				sprite.play("p1_idleSpearDown")
			elif facing == Directions.UP:
				sprite.play("p1_idleSpearUp")
		#idle for gun
		else:
			if facing == Directions.LEFT:
				sprite.play("p1_idleGunDownLeft")
			elif facing == Directions.RIGHT:
				sprite.play("p1_idleGunDownRight")
			elif facing == Directions.DOWN:
				sprite.play("p1_idleGunDown")
			elif facing == Directions.UP:
				sprite.play("p1_idleGunUp")





func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()


	if Input.is_action_just_pressed("p1_x"):
		currentWeapon += 1
	if currentWeapon >= 2:
		currentWeapon = 0


	direction = Input.get_vector("p1_left", "p1_right", "p1_up", "p1_down")
	#Movement
	velocity = direction * SPEED
	#Walk with spear Aniamtion
	if direction.x < 0 && isSprinting == false && currentWeapon == 0 && isAttacking == false:
		sprite.play("p1_spearWalkDownLeft")
		facing = Directions.LEFT
	elif direction.x > 0 && isSprinting == false && currentWeapon == 0 && isAttacking == false:
		sprite.play("p1_spearWalkDownRight")
		facing = Directions.RIGHT
	elif direction.y > 0 && isSprinting == false && currentWeapon == 0 && isAttacking == false:
		sprite.play("p1_spearWalkDown")
		facing = Directions.DOWN
	elif direction.y < 0 && isSprinting == false && currentWeapon == 0 && isAttacking == false:
		sprite.play("p1_spearWalkUp")
		facing = Directions.UP
	#Walk with gun
	if direction.x < 0 && isSprinting == false && currentWeapon == 1 && isAttacking == false:
		sprite.play("p1_gunWalkDownLeft")
		facing = Directions.LEFT
	elif direction.x > 0 && isSprinting == false && currentWeapon == 1 && isAttacking == false:
		sprite.play("p1_gunWalkDownRight")
		facing = Directions.RIGHT
	elif direction.y > 0 && isSprinting == false && currentWeapon == 1 && isAttacking == false:
		sprite.play("p1_gunWalkDown")
		facing = Directions.DOWN
	elif direction.y < 0 && isSprinting == false && currentWeapon == 1 && isAttacking == false:
		sprite.play("p1_gunWalkUp")
		facing = Directions.UP
	
		
	#Sprint
	if Input.is_action_pressed("p1_a"):
		SPEED = 200
		isSprinting = true
	else:
		SPEED = 150
		isSprinting = false
	# if Input.is_action_pressed("p1_l1"):
	# 	print("boom")
	# 	isAttacking = true
	# 	if facing == Directions.DOWN && isAttacking == true:
	# 		sprite.play("p1_spearDown")














	_set_direction()
	_set_animation()
	move_and_slide()
