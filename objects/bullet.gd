extends Area2D
class_name EnemyBullet

var speed : float = 355.0

@export var death_timer : float = 1
var death_time : float

var direction : Vector2

func _ready() -> void:
	death_time = death_timer

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	
	if death_time > 0:
		death_time -= delta
	else :
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	queue_free()
