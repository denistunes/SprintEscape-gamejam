extends Area2D

const LASTFLOOR = preload("res://scenes/lastfloor.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().change_scene_to_packed(LASTFLOOR)
