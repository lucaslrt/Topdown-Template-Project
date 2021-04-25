extends AnimatedSprite

onready var animatedSprite = $AnimatedSprite

func _ready():
	connect("animation_finished", self, "_on_animation_finished")
	play("Animate")
	pass

func _on_animation_finished():
	queue_free()
	pass
