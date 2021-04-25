extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

var invincible = false setget set_invincible

onready var timer = $Timer
onready var collision_shape = $CollisionShape2D

signal invincibility_started
signal invincibility_ended

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")
	pass

func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)
	pass

func show_hit_effect():
	var hit_effect = HitEffect.instance()
	var main_node = get_tree().current_scene
	main_node.add_child(hit_effect)
	hit_effect.global_position = global_position
	pass

func _on_Hurtbox_area_entered(area):
	pass # Replace with function body.

func _on_Timer_timeout():
	self.invincible = false #precisa ter o self senão não chama o método set_invincible
	pass # Replace with function body.

func _on_Hurtbox_invincibility_started():
	collision_shape.set_deferred("disabled", true)
	#set_deferred é utilizado quando o método precisa esperar todos os processos
	#da fisica do jogo terminarem de serem feitos para poder rodar
	pass # Replace with function body.

func _on_Hurtbox_invincibility_ended():
	collision_shape.disabled = false
	pass # Replace with function body.
