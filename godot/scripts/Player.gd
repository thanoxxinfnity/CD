extends CharacterBody3D
# First-person player controller: WASD move, mouse look, jump, raycast shoot.

const SPEED: float = 6.0
const SPRINT_SPEED: float = 9.5
const JUMP_VELOCITY: float = 4.5
const MOUSE_SENSITIVITY: float = 0.0025
const SHOOT_DAMAGE: int = 40
const SHOOT_RANGE: float = 60.0

@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D
@onready var muzzle_raycast: RayCast3D = $Head/Camera3D/MuzzleRayCast

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	GameManager.player_health_changed.connect(_on_health_changed)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		head.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-80), deg_to_rad(80))
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var speed: float = SPRINT_SPEED if Input.is_key_pressed(KEY_SHIFT) else SPEED

	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

	if Input.is_action_just_pressed("shoot"):
		_shoot()

func _shoot() -> void:
	if muzzle_raycast.is_colliding():
		var target: Object = muzzle_raycast.get_collider()
		if target and target.has_method("take_damage"):
			target.take_damage(SHOOT_DAMAGE)

func take_damage(amount: int) -> void:
	GameManager.damage_player(amount)

func _on_health_changed(health: int, _max_health: int) -> void:
	if health <= 0:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		set_physics_process(false)
