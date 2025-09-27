extends Area2D

var open: bool = false

func _ready() -> void:
	PlayerState.state_changed.connect(_refresh)
	_refresh()
	connect("body_entered", Callable(self, "_on_body_entered"))

func _refresh() -> void:
	open = not PlayerSadtate.can_dash
	#if has_node("Label"):
		#$Label.text = open ? "Gate open — go!" : "Gate sealed — sacrifice DASH to pass."

func _on_body_entered(body: Node) -> void:
	if open and body.name == "Player":
		_show_win()

func _show_win() -> void:
	print("YOU WIN!")
	# Simple win UI:
	var popup := Label.new()
	popup.text = "YOU WIN!"
	popup.position = Vector2(40, 40)
	get_tree().current_scene.add_child(popup)
