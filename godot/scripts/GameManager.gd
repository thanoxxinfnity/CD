extends Node
# Global game state: autoloaded as "GameManager".

signal player_health_changed(health: int, max_health: int)
signal wave_changed(wave: int)
signal game_over

var player_health: int = 100
var player_max_health: int = 100
var current_wave: int = 0
var zombies_alive: int = 0
var score: int = 0

func reset_game() -> void:
	player_health = player_max_health
	current_wave = 0
	zombies_alive = 0
	score = 0
	player_health_changed.emit(player_health, player_max_health)
	wave_changed.emit(current_wave)

func damage_player(amount: int) -> void:
	player_health = clamp(player_health - amount, 0, player_max_health)
	player_health_changed.emit(player_health, player_max_health)
	if player_health <= 0:
		game_over.emit()

func start_wave(wave: int) -> void:
	current_wave = wave
	wave_changed.emit(current_wave)

func register_zombie_spawned() -> void:
	zombies_alive += 1

func register_zombie_killed() -> void:
	zombies_alive = max(0, zombies_alive - 1)
	score += 10
