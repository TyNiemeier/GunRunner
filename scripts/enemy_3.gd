extends Enemy

const fireball_scene = preload("res://scenes/entities/Enemy/fireball.tscn")
@onready var shoot_timer = $ShootTimer
@onready var rotater = $Rotater
var damage = 10

const rotate_speed = 22.5
const shooter_timer_wait_time = 1
const spawn_point_count = 8
const radius = 20

func _ready():
	var step = 2 * PI / spawn_point_count

	for i in range(spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotater.add_child(spawn_point)

	shoot_timer.wait_time = shooter_timer_wait_time
	shoot_timer.start()

func _on_fireball_range_body_entered(body):
	if body is Player:
		in_range = true


func _on_fireball_range_body_exited(body):
	if body is Player:
		in_range = false

func _process(delta: float) -> void:
	var new_rotation = rotater.rotation_degrees + rotate_speed * delta
	rotater.rotation_degrees = fmod(new_rotation, 360)


func _on_shoot_timer_timeout() -> void:
	if in_range:
		for s in rotater.get_children():
			var fireball = fireball_scene.instantiate()
			get_tree().root.add_child(fireball)
			fireball.position = s.global_position
			fireball.rotation = s.global_rotation # Replace with function body.
