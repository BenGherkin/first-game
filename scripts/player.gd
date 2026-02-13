extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var isDying = 0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_note: AnimationPlayer = $deathNote
@onready var death_sound: AudioStreamPlayer2D = $deathSound
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var jump_note: AnimationPlayer = $jumpNote

func die():
	isDying = 1
	animated_sprite.play("death")
	death_note.play("death")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and isDying==0:
		velocity.y = JUMP_VELOCITY
		jump_note.play("jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#get the input direct: -1,0,1
	var direction := Input.get_axis("move_left", "move_right")
	
	#flip the sprite
	if direction > 0 and isDying==0:
		animated_sprite.flip_h = false
	elif direction < 0 and isDying==0:
		animated_sprite.flip_h = true
	
	#play animations
	if is_on_floor():
		if direction == 0 && isDying == 0:
			animated_sprite.play("idle")
		elif (direction > 0 || direction < 0) && isDying == 0 :
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	#apply movement
	if direction and isDying==0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
