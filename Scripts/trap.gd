extends Node2D

# signal created
signal touchedPlayer

# Detect when player enters the trap
func _on_area_2d_body_entered(body):
	if (body is Player):
		touchedPlayer.emit()
