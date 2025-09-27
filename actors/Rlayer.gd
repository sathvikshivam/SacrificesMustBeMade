extends CharacterBody2D

@export var speed: float = 200.0
@export var jump_force: float = 420.0
@export var gravity: float = 1200.0

var jumps_left: int = 2
var dash_cd: float = 0.35
var dash_t: float = 0.0

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

	# Jump
	if Input.is_action_just_pressed("jump") and jumps_left > 0:
		velocity.y = -jump_force
		jumps_left -= 1

	# Dash (only if not sacrificed)
	dash_t = max(0.0, dash_t - delta)
	if PlayerState.can_dash and dash_t == 0.0 and Input.is_action_just_pressed("dash"):
		var d: float = sign(velocity.x)
		if d == 0: d = 1
		velocity.x = d * speed * 3.0
		dash_t = dash_cd

	move_and_slide()
