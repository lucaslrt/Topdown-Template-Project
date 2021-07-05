extends KinematicBody2D
class_name Character

const PlayerHurtSound = preload("res://Player/PlayerHurtSound.tscn")
var inventory: Inventory = preload("res://Weapons/Inventory.tres")

var velocity = Vector2.ZERO
var current_direction = Vector2.DOWN
var stats = PlayerStats

onready var state_machine = $StateMachine
onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = $AnimationTree.get("parameters/playback")
onready var hitbox_pivot = $HitboxPivot
onready var hurtbox = $Hurtbox
onready var blink_effect = $BlinkEffectAnimationPlayer

func _ready():
	randomize()
	stats.connect("no_health", self, "queue_free")
	animation_tree.active = true
	state_machine.current_state = $StateMachine/MoveState
	pass

func _apply_movement():
	velocity = move_and_slide(velocity)
	pass

func _unhandled_input(event):
	if event.is_action_pressed("ui_select_weapon_1"):
		select_weapon(0)
	elif event.is_action_pressed("ui_select_weapon_2"):
		select_weapon(1)
	elif event.is_action_pressed("ui_select_weapon_3"):
		select_weapon(2)
	pass

func select_weapon(position):
	var weapon: WeaponItem = inventory.get_selected_item(position)
	if weapon != null:
		change_hitbox(weapon.hitbox_collision_area)
		stats.current_attack = weapon.name

func add_weapon(weapon: WeaponItem):
	inventory.add_item(weapon)
	select_weapon(inventory.get_item_position(weapon))
	pass

func change_hitbox(hitbox: PackedScene):
	hitbox_pivot.remove_child(hitbox_pivot.get_child(0))
	var new_weapon_hitbox = hitbox.instance()
	hitbox_pivot.add_child(new_weapon_hitbox)

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
