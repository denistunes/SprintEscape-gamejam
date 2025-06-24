extends GPUParticles2D

func _ready() -> void:
	emitting = true
	finished.connect(_destroyself)

func _destroyself() -> void:
	queue_free()
