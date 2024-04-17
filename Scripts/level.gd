extends Node2D

@export var nextLevel: PackedScene = null
@export var levelTime = 120
@export var isFinalLevel: bool = false

@onready var start = $Start
@onready var exit = $Exit
@onready var deathZone = $Deathzone
@onready var hud = $UILayer/HUD
@onready var uiLayer = $UILayer

var player = null
var timerNode = null
var timeLeft
var win = false

func _ready():
	player = get_tree().get_first_node_in_group("player")
	if (player != null):
		player.global_position = start.getSpawnPosition()

	var traps = get_tree().get_nodes_in_group("traps")
	# Connect each trap to the _on_trap_touched_player method 
	for trap in traps:
		#trap.connect("touchedPlayer", _on_trap_touched_player)
		trap.touchedPlayer.connect(_on_trap_touched_player)
		
	exit.body_entered.connect(on_exit_body_entered)
	deathZone.body_entered.connect(_on_deathzone_body_entered)
	
	timeLeft = levelTime
	hud.setTimeLabel(timeLeft)
	
	timerNode = Timer.new()
	timerNode.name = "Level Timer"
	timerNode.wait_time = 1
	timerNode.timeout.connect(_on_level_timer_timeout)
	add_child(timerNode)
	timerNode.start()

# Reduce timeLeft per second 
func _on_level_timer_timeout():
	if (!win):
		timeLeft -= 1
		hud.setTimeLabel(timeLeft)
		if (timeLeft < 0):
			AudioPlayer.playSfx("hurt")
			resetPlayer()
			timeLeft = levelTime
			hud.setTimeLabel(timeLeft)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("quit")):
		get_tree().quit()
	elif (Input.is_action_just_pressed("reset")):
		get_tree().reload_current_scene()

# Reset player position to the start position when player falls off map
func _on_deathzone_body_entered(body):
	AudioPlayer.playSfx("hurt")
	resetPlayer()

# Reset player position to the start position when player touches a trap
func _on_trap_touched_player():
	AudioPlayer.playSfx("hurt")
	resetPlayer()

#  Reset player position to the start position
func resetPlayer():
	player.velocity = Vector2.ZERO
	player.global_position = start.getSpawnPosition()

# Animate the Exit and swtich to next Scene 
func on_exit_body_entered(body):
	if (body is Player):
		if (isFinalLevel || (nextLevel != null)):
			exit.animate()
			player.active = false
			win = true
			await get_tree().create_timer(1.5).timeout
			if (isFinalLevel):
				uiLayer.showWinScreen(true)
			else:
				get_tree().change_scene_to_packed(nextLevel)
