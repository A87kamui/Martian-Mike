extends CharacterBody2D
class_name Player

@export var gravity = 400
@export var speed = 125
@export var jumpForce = 200

@onready var animatedSprite = $AnimatedSprite2D

var active = true


func _physics_process(delta):
	if (!is_on_floor()):
		velocity.y += gravity * delta
		if (velocity.y > 500):
			velocity.y = 500
	
	var direction = 0
	if (active):
		if (is_on_floor() && Input.is_action_just_pressed("jump")):
			jump(jumpForce)
		
		direction = Input.get_axis("move_left", "move_right")
	
	if (direction != 0):
		animatedSprite.flip_h = (direction == -1)	# Sets flip_h to be t/f if direction == -1
	
	velocity.x = direction * speed
	move_and_slide()	# Allow player to move
	
	updateAnimation(direction) 

# Apply jump to player
func jump(force):
	AudioPlayer.playSfx("jump")
	velocity.y = -force

# Update animation of player 
func updateAnimation(direction):
	if (is_on_floor()):
		if (direction == 0):
			animatedSprite.play("idle")
		else:
			animatedSprite.play("run")
	else:
		if (velocity.y < 0):	# Player is jumping
			animatedSprite.play("jump")
		else:
			animatedSprite.play("fall")
