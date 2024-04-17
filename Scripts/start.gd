extends StaticBody2D

@onready var spawnPosition = $SpawnPosition

# Return the global position of the SpawnPosition
func getSpawnPosition():
	return spawnPosition.global_position
