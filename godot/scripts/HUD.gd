extends CanvasLayer

@onready var health_label: Label = $HealthLabel
@onready var wave_label: Label = $WaveLabel
@onready var game_over_label: Label = $GameOverLabel

func _ready() -> void:
	GameManager.player_health_changed.connect(_on_health_changed)
	GameManager.wave_changed.connect(_on_wave_changed)
	GameManager.game_over.connect(_on_game_over)
	game_over_label.hide()
	_on_health_changed(GameManager.player_health, GameManager.player_max_health)
	_on_wave_changed(GameManager.current_wave)

func _on_health_changed(health: int, max_health: int) -> void:
	health_label.text = "Health: %d / %d" % [health, max_health]

func _on_wave_changed(wave: int) -> void:
	wave_label.text = "Wave: %d" % wave

func _on_game_over() -> void:
	game_over_label.show()
