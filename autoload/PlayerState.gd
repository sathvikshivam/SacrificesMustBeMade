extends Node

signal state_changed

# Only track what we need for this mini-game
var can_dash: bool = true

func reset() -> void:
	can_dash = true
	state_changed.emit()

func sacrifice_dash() -> void:
	can_dash = false
	state_changed.emit()
