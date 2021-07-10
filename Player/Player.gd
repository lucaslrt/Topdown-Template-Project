extends Character
class_name Player

const PlayerHurtSound = preload("res://Player/PlayerHurtSound.tscn")
var inventory: Inventory = preload("res://Weapons/Inventory.tres")

#var velocity = Vector2.ZERO
#var current_direction = Vector2.DOWN
var stats = PlayerStats

#onready var state_machine = $StateMachine
onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = $AnimationTree.get("parameters/playback")
onready var hitbox_pivot = $HitboxPivot
#onready var hurtbox = $Hurtbox
onready var blink_effect = $BlinkEffectAnimationPlayer

func _ready():
	randomize()
	stats.connect("no_health", self, "queue_free")
	animation_tree.active = true
	state_machine.current_state = $StateMachine/MoveState
	pass

func add_weapon(weapon: WeaponItem):
	inventory.add_item(weapon)
	state_machine.get_node("AttackState").select_weapon(inventory.get_item_position(weapon))
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
