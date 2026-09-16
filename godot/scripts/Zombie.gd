extends CharacterBody3D
# Basic zombie AI: navigate toward the player, attack on contact.
# Swap the MeshInstance3D's mesh for a generated Hunyuan3D model when ready
# (see godot/assets/generated_models/README.md).

const SPEED: float = 2.4
const ATTACK_RANGE: float = 1.6
const ATTACK_DAMAGE: int = 10
const ATTACK_COOLDOWN: float = 1.0
const MAX_HEALTH: int = 60

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var mesh: MeshInstance3D = $MeshInstance3D

var health: int = MAX_HEALTH
var attack_timer: float = 0.0
var player: Node3D = null
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	GameManager.register_zombie_spawned()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

	if attack_timer > 0.0:
		attack_timer -= delta

	if player == null:
		move_and_slide()
		return

	var distance_to_player: float = global_position.distance_to(player.global_position)

	if distance_to_player <= ATTACK_RANGE:
		velocity.x = 0
		velocity.z = 0
		if attack_timer <= 0.0:
			_attack_player()
	else:
		nav_agent.target_position = player.global_position
		var next_path_pos: Vector3 = nav_agent.get_next_path_position()
		var direction: Vector3 = (next_path_pos - global_position)
		direction.y = 0
		direction = direction.normalized()
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if direction.length() > 0.01:
			look_at(global_position + direction, Vector3.UP)

	move_and_slide()

func _attack_player() -> void:
	attack_timer = ATTACK_COOLDOWN
	if player.has_method("take_damage"):
		player.take_damage(ATTACK_DAMAGE)

func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		_die()

func _die() -> void:
	GameManager.register_zombie_killed()
	queue_free()
