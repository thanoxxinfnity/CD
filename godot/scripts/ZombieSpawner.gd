extends Node3D
# Place several of these around the map. Each spawns zombies on a timer
# and scales spawn rate up with GameManager.current_wave.

@export var zombie_scene: PackedScene = preload("res://scenes/Zombie.tscn")
@export var base_interval: float = 5.0
@export var min_interval: float = 1.2
@export var max_zombies_from_this_spawner: int = 6

var _spawned_count: int = 0
var _timer: float = 0.0

func _ready() -> void:
	_timer = base_interval

func _process(delta: float) -> void:
	if _spawned_count >= max_zombies_from_this_spawner:
		return
	_timer -= delta
	if _timer <= 0.0:
		_spawn_zombie()
		var interval: float = base_interval - (GameManager.current_wave * 0.4)
		_timer = max(min_interval, interval)

func _spawn_zombie() -> void:
	var zombie: Node3D = zombie_scene.instantiate()
	get_tree().current_scene.add_child(zombie)
	zombie.global_position = global_position
	_spawned_count += 1
