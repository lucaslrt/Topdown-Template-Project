extends Character
class_name FlyingEnemy

const FlyingEnemyDeathEffect = preload("res://Enemies/FlyingEnemyDeathEffect.tscn")

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var PATROL_TARGET_RANGE = 4

enum {
	IDLE,
	PATROL,
	CHASE
}

var knockback = Vector2.ZERO
var state = CHASE

onready var sprite = $Sprite
onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetection
onready var soft_collision = $SoftCollision
onready var patrol_state = $StateMachine/PatrolState

func _ready():
	$StateMachine.current_state = $StateMachine/IdleState
	pass

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)

	if soft_collision.is_colliding():
		velocity += soft_collision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)
	pass

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE
	pass

func update_state():
	if patrol_state.get_time_left() == 0:
		_update_patrol()

func _update_patrol():
	state = pick_random_state([IDLE, PATROL])
	match(state):
		IDLE:
			state_machine.change_state_by_name("IdleState")
		PATROL:
			state_machine.change_state_by_name("PatrolState")
	patrol_state.start_patrol_timer(rand_range(1, 3))
	pass

func _accelerate_twoards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0
	velocity = move_and_slide(velocity)
	pass

func _show_death_effect():
	var death_effect = FlyingEnemyDeathEffect.instance()
	get_parent().add_child(death_effect)
	death_effect.global_position = global_position
	pass

func _on_Hurtbox_area_entered(area: Area2D):
	print("FlyingEnemy -> area.disabled = ", area.get_node("CollisionShape2D").disabled)
	if !area.get_node("CollisionShape2D").disabled:
		stats.current_health -= area.damage
		var character = area.get_parent().get_parent()
		knockback = character.current_direction * 120
		hurtbox.show_hit_effect()
	pass

func _on_Stats_no_health():
	_show_death_effect()
	queue_free()
	pass

func _on_Timer_timeout():
	pass # Replace with function body.
