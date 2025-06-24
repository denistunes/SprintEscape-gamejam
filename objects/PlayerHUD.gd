extends Control

@onready var player: Player = $"../.."

@onready var death_panel: Control = $DeathPanel

func _ready() -> void:
	death_panel.visible = false

func _physics_process(delta: float) -> void:
	if player.is_dead:
		death_panel.visible = true


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
