extends ParallaxBackground

@export var backGroundTexture: CompressedTexture2D = preload("res://martian_mike_assets/textures/bg/Blue.png")
@export var scrollSpeed = 15
@onready var sprite = $ParallaxLayer/Sprite2D

# Set background texture 
func _ready():
	sprite.texture = backGroundTexture

# Create the background moving effect
func _process(delta):
	sprite.region_rect.position += delta * Vector2(scrollSpeed, scrollSpeed)
	if (sprite.region_rect.position >= Vector2(64, 64)):
		sprite.region_rect.position = Vector2.ZERO
