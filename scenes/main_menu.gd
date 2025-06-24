extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

const JAIL = preload("res://scenes/jail.tscn")

func _ready() -> void:
	$Control/Light/Menu.visible = true
	$Control/Light/Controls.visible = false

func _on_start_button_pressed() -> void:
	$Control/Light/Menu.visible = false
	$Control/Light/Controls.visible = true
	animation_player.play("controls")
	

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(JAIL)
