extends Node3D
# Root of the playable scene: runs a simple wave counter.

@export var seconds_per_wave: float = 30.0

var _wave_timer: float = 0.0

func _ready() -> void:
	GameManager.reset_game()
	GameManager.start_wave(1)
	_wave_timer = seconds_per_wave

func _process(delta: float) -> void:
	_wave_timer -= delta
	if _wave_timer <= 0.0:
		GameManager.start_wave(GameManager.current_wave + 1)
		_wave_timer = seconds_per_wave
