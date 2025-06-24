extends Node2D

@export var max_notice : float = 0.4
@export_group("Scan Variables")
@export var first_scan_rot : float = -30.0
@export var second_scan_rot : float = 30.0
@export var wait_time : float = 1
@export var scan_speed : float = 2

var notice_bar : float
var player_noticed : bool
var distance_to_player : Vector2

var shoot_timer : float

var tween : Tween
var player : Player

@onready var polygon_2d: Polygon2D = $Polygon2D
@onready var shoot_pos: Marker2D = $ShootPos
@onready var shoot_sound: AudioStreamPlayer = $ShootSound


const BULLET = preload("res://objects/bullet.tscn")

func _ready() -> void:
	rotation = deg_to_rad(second_scan_rot)
	tween = create_tween().set_loops(0)
	tween.tween_interval(wait_time)
	tween.tween_property(self, "rotation", deg_to_rad(first_scan_rot), scan_speed)
	tween.tween_interval(wait_time)
	tween.tween_property(self, "rotation", deg_to_rad(second_scan_rot), scan_speed)

func _physics_process(delta: float) -> void:
	if player_noticed:
		notice_bar += delta
	else :
		notice_bar -= delta
	
	var white = Color(1.0, 1.0, 1.0)
	var red = Color(1.0, 0.0, 0.0)

	var clol = white.lerp(red, notice_bar * 2)
	
	polygon_2d.color = clol
	
	notice_bar = clamp(notice_bar, 0, max_notice)
	
	if player:
		distance_to_player = player.global_position - global_position
		
		if player.is_dead:
			player_noticed = false

	if notice_bar == max_notice:
		tween.stop()
		look_at(player.position)
		if shoot_timer > 0:
			shoot_timer -= delta
		else :
			shoot_timer = 0.05
			_shoot()
	else :
		tween.play()

func _shoot() -> void:
	shoot_sound.play()
	var B = BULLET.instantiate()
	B.position = shoot_pos.global_position
	B.direction = distance_to_player.normalized()
	get_tree().current_scene.add_child(B)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body
		player_noticed = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		player = null
		player_noticed = false
