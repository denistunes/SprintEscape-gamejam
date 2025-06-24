extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var next_scene : PackedScene

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		animation_player.play("close")
		await animation_player.animation_finished
		get_tree().change_scene_to_packed(next_scene)
