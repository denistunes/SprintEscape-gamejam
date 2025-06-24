extends CharacterBody2D
class_name Player

var main_speed : float
var move_speed : float = 75.0
var stealth_speed : float = 225.0

var raw_input : Vector2
var is_invisible : bool
var is_dead : bool

var max_stealth_time : float = 0.35
var stealth_time : float

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var hide_sound: AudioStreamPlayer = $Dash_Sound
@onready var ded_sound: AudioStreamPlayer = $Ded_Sound

const STEALTH_SMOKE = preload("res://objects/particles/stealth_smoke.tscn")

func _ready() -> void:
	stealth_time = max_stealth_time

func _physics_process(delta: float) -> void:
	raw_input = Input.get_vector("Left","Right","Up","Down")
	
	_movement()
	
	if is_invisible:
		if stealth_time > 0:
			stealth_time -= delta
		else :
			is_invisible = false
	else :
		main_speed = move_speed
		if stealth_time != max_stealth_time:
			stealth_time += delta
	
	#print(stealth_time)
	
	move_and_slide()

func _movement() -> void:
	
	if not is_dead:
		velocity = raw_input * main_speed
	else :
		velocity = Vector2.ZERO
		sprite.play("dead")
	
	if Input.is_action_just_pressed("Stealth") and not is_invisible and not is_dead and stealth_time == max_stealth_time:
		main_speed = stealth_speed
		var P = STEALTH_SMOKE.instantiate()
		add_child(P)
		hide_sound.play()
		is_invisible = true


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is EnemyBullet:
		ded_sound.play()
		is_dead = true
