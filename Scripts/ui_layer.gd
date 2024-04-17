extends CanvasLayer

@onready var winScreen = $WinScreen

# Activate/Deactivate win screen
func showWinScreen(flag: bool):
	$WinScreen.visible = flag
