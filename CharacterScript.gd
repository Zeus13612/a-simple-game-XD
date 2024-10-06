extends CharacterBody2D

var state = 0

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var _animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("ui_accept"):
		_animated_sprite.play("jump")
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if Input.is_action_just_pressed("ui_right"):
			_animated_sprite.flip_h = 0
			_animated_sprite.play("run")
		if Input.is_action_just_pressed("ui_left"):
			_animated_sprite.flip_h = 1
			_animated_sprite.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		_animated_sprite.play("default")
		if not _animated_sprite.is_playing() and not Input.get_axis("ui_right", "ui_left") and not Input.is_action_just_pressed("ui_accept") and is_on_floor():
			_animated_sprite.play_backwards("default")
			#TODO: dar o cu e fazer pacto com o capeta pra ver se isso funciona pqp
			
			
			#Meu tio harry tinha um sitio ia ia o (TERMINA A MUSICA FDP)

	move_and_slide()
