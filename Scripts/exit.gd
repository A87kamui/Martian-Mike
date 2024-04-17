extends Area2D

@onready var animatedSprite = $AnimatedSprite2D

# Animate Exit 
func animate():
	animatedSprite.play("default")
