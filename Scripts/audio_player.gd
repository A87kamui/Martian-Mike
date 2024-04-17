extends Node

var hurt = preload("res://martian_mike_assets/audio/hurt.wav")
var jump = preload("res://martian_mike_assets/audio/jump.wav")

# Plays one time sfx 
func playSfx(sfxName: String):
	var stream = null
	
	if (sfxName == "hurt"):
		stream = hurt
	elif (sfxName == "jump"):
		stream = jump
	else:
		print("Invalid Name")
		return
	
	var audioPlayer = AudioStreamPlayer.new()
	audioPlayer.stream = stream
	audioPlayer.name = "SFX"
	
	add_child(audioPlayer)
	audioPlayer.play()
	
	await audioPlayer.finished
	audioPlayer.queue_free()
