extends KinematicBody2D
class_name Character

const PlayerHurtSound = preload("res://Player/PlayerHurtSound.tscn")

var velocity = Vector2.ZERO
var current_direction = Vector2.DOWN
var stats = PlayerStats

onready var state_machine = $StateMachine
onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = $AnimationTree.get("parameters/playback")
onready var weapon_hitbox = $HitboxPivot/Hitbox
onready var hurtbox = $Hurtbox
onready var blink_effect = $BlinkEffectAnimationPlayer

func _ready():
	randomize()
	stats.connect("no_health", self, "queue_free")
	animation_tree.active = true
	state_machine.current_state = $StateMachine/MoveState
	pass
#
## warning-ignore:unused_argument
#func _physics_process(delta):
#	pass

func add_weapon_hitbox(new_weapon_hitbox):
	var new_collision_shape = weapon_hitbox.get_node("CollisionShape2D")
	new_weapon_hitbox.remove_child(new_collision_shape)
	new_collision_shape.disabled = true
	
	self.weapon_hitbox.remove_child($HitboxPivot/Hitbox/CollisionShape2D)
	self.weapon_hitbox.add_child(new_collision_shape)
	
	print("Player -> weapon_hitbox.disabled = ", self.weapon_hitbox.get_node("CollisionShape2D").disabled)
	pass

func _apply_movement():
	velocity = move_and_slide(velocity)
	pass

func _unhandled_key_input(event):
	pass

func _on_Hurtbox_area_entered(area):
	print("Player -> hurtbox area entered: ", area.name)
	stats.current_health -= 1
	hurtbox.start_invincibility(0.5)
	hurtbox.show_hit_effect()
	var playerHurtSound = PlayerHurtSound.instance()
	get_tree().current_scene.add_child(playerHurtSound)
	pass # Replace with function body.

func _on_Hurtbox_invincibility_started():
	blink_effect.play("Start")
	pass # Replace with function body.

func _on_Hurtbox_invincibility_ended():
	blink_effect.play("Stop")
	pass # Replace with function body.
