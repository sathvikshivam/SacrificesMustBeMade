extends Area2D
@onready var player = preload("res://scenes/Player.tscn")
var current = null

func _ready():
	connect("body_entered",Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body is CharacterBody2D:
		body.queue_free()
		current = player.instantiate()
		current.global_position = Vector2(-200,279)
		get_tree().current_scene.add_child(current)
		
