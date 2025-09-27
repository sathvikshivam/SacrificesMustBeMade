extends Area2D

var player_inside: bool = false

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body: Node) -> void:
	if body is CharacterBody2D and body.name == "Player":
		player_inside = true

func _on_body_exited(body: Node) -> void:
	if body is CharacterBody2D and body.name == "Player":
		player_inside = false

func _unhandled_input(event: InputEvent) -> void:
	if player_inside and event.is_action_pressed("interact"):
		if PlayerState.can_dash:
			PlayerState.sacrifice_dash()
			# Optional: change label to confirm
			if has_node("Label"):
				$Label.text = "Dash sacrificed!"
