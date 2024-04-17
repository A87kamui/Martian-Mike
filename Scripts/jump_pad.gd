extends Area2D

@export var jumpForce = 300

@onready var animatedSprite = $AnimatedSprite2D

# Activate the jump animation
func _on_body_entered(body):
	if body is Player:
		animatedSprite.play("jump")
		body.jump(jumpForce)
