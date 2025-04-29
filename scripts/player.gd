extends CharacterBody2D
class_name player


@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@export var playerId : int = 0
enum Directions {UP, DOWN, LEFT, RIGHT, RIGHTUP, LEFTUP, RIGHTDOWN, LEFTDOWN}
var facing : Directions = Directions.DOWN
var direction: Vector2 = Vector2.ZERO
var isSprinting = false
var SPEED: int = 150
var currentWeapon = 0
var isAttacking = false

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
	#Sprint with spear Animation
	elif direction.x < 0 && isSprinting == true && currentWeapon == 0 && isAttacking == false:
		sprite.play("p1_spearRunDownLeft")
		facing = Directions.LEFT
	elif direction.x > 0 && isSprinting == true && currentWeapon == 0 && isAttacking == false:
		sprite.play("p1_spearRunDownRight")
		facing = Directions.RIGHT
	elif direction.y > 0 && isSprinting == true && currentWeapon == 0 && isAttacking == false:
		sprite.play("p1_spearRunDown")
		facing = Directions.DOWN
	elif direction.y < 0 && isSprinting == true && currentWeapon == 0 && isAttacking == false:
		sprite.play("p1_spearRunUp")
		facing = Directions.UP
	#idle with spear Animation
	elif direction.x == 0 && direction.y == 0 && currentWeapon == 0 && isAttacking == false:
		# Player is idle, check facing direction and choose appropriate idle animation
		if facing == Directions.LEFT:
			sprite.play("p1_idleSpearDownLeft")
		elif facing == Directions.RIGHT:
			sprite.play("p1_idleSpearDownRight")
		elif facing == Directions.DOWN:
			sprite.play("p1_idleSpearDown")
		elif facing == Directions.UP:
			sprite.play("p1_idleSpearUp")
	#Spear attack animations
	
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
	#Sprint with spear Animation
	elif direction.x < 0 && isSprinting == true && currentWeapon == 1 && isAttacking == false:
		sprite.play("p1_gunRunDownLeft")
		facing = Directions.LEFT
	elif direction.x > 0 && isSprinting == true && currentWeapon == 1 && isAttacking == false:
		sprite.play("p1_gunRunDownRight")
		facing = Directions.RIGHT
	elif direction.y > 0 && isSprinting == true && currentWeapon == 1 && isAttacking == false:
		sprite.play("p1_gunRunDown")
		facing = Directions.DOWN
	elif direction.y < 0 && isSprinting == true && currentWeapon == 1 && isAttacking == false:
		sprite.play("p1_gunRunUp")
		facing = Directions.UP
	#idle with spear Animation
	elif direction.x == 0 && direction.y == 0 && currentWeapon == 1 && isAttacking == false:
		# Player is idle, check facing direction and choose appropriate idle animation
		if facing == Directions.LEFT:
			sprite.play("p1_idleGunDownLeft")
		elif facing == Directions.RIGHT:
			sprite.play("p1_idleGunDownRight")
		elif facing == Directions.DOWN:
			sprite.play("p1_idleGunDown")
		elif facing == Directions.UP:
			sprite.play("p1_idleGunUp")
	#Sprint
	if Input.is_action_pressed("p1_a"):
		SPEED = 200
		isSprinting = true
	else:
		SPEED = 150
		isSprinting = false













#put player id back in input.get_axis when setting up two player
	# var hDirection = Input.get_axis("p1_left", "p1_right")
	# if hDirection:
	# 	velocity.x = hDirection * SPEED
	# 	if hDirection < 0:
	# 		#left
	# 		sprite.play("walk")
	# 		sprite.flip_h = true
	# 		facing = Directions.LEFT
	# 	else:
	# 		#right
	# 		sprite.play("walk")
	# 		sprite.flip_h = false
	# 		facing = Directions.RIGHT
	# else:
	# 	velocity.x = move_toward(velocity.x, 0, SPEED)


	# var vDirection = Input.get_axis("p1_up", "p1_down")
	# if vDirection:
	# 	velocity.y = vDirection * SPEED
	# 	if vDirection < 0:
	# 		#Up
	# 		sprite.play("walk")
	# 	else:
	# 		#down
	# 		sprite.play("walk")
	# else:
	# 	velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
