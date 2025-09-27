extends Area2D
@onready var player = preload("res://scenes/Player.tscn")

@onready var audio_player = $AudioStreamPlayer
@onready var music = load("res://assets/sounds/victory-chime-366449.mp3")
var current = null

func _ready():
	connect("body_entered",Callable(self, "_on_body_entered"))



func _on_body_entered(body: Node):
	if body.name == "Player":
		audio_player.play()
