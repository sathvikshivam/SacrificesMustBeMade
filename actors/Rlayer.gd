extends CharacterBody2D

@export var speed: float = 200.0
@export var jump_force: float = 420.0
@export var gravity: float = 1200.0
@onready var animated_sprite = $AnimatedSprite2D
@export var sprint_speed_multiplier: float = 2.250 # Adjust this value as needed

var one_use = true
var jumps_left: int = 2
var dash_cd: float = 0.35
var dash_t: float = 0.0
var can_dash: bool = true

func _ready() -> void:
	$Camera2D.make_current()

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		jumps_left = 2

	# Horizontal
	var dir: float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = dir * speed
	if dir<0:
		animated_sprite.flip_h = true
	if dir>0:
		animated_sprite.flip_h = false
		var current_speed = speed
		
	if Input.is_action_just_pressed("jump") and jumps_left > 0:
		velocity.y = -jump_force
		jumps_left -= 1
	
	if Input.is_action_just_pressed("interact") and one_use:
		can_dash = !can_dash
		one_use = false
		collision_layer=2
		collision_mask=2
		
	var current_speed = speed 
	if Input.is_action_pressed("sprint") and can_dash: # Sprinting logic
		current_speed *= sprint_speed_multiplier
	
	velocity.x = dir * current_speed # Apply the current speed
	dash_t = max(0.0, dash_t - delta)

	# Dash (only if not sacrificed)


	move_and_slide()
