extends Area2D

@export var SPEED = 200
@export var DAMAGE = 15

var direction:Vector2

func _ready():
    await get_tree().create_timer(3)._on_hitboxtimer_timeout
    queue_free()


func set_direction(bulletDirection):
    direction = bulletDirection
    rotation_degrees = rad_to_deg(global_position.angle_to_point(global_position + direction))

func _physics_process(delta):
    global_position += direction * SPEED * delta

    

func _on_body_entered(body):
    if body.is_in_group("enemies"):
        body.get_damage(DAMAGE)
        queue_free()
