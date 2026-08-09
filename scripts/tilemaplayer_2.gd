extends TileMapLayer

@onready var player: CharacterBody2D = null # Initialize as null
var target_tile: Vector2i = Vector2i(1, 1)
var max_distance_in_tiles: int = 2

func _ready():
	pass
	# Debug: Check if the path exists before trying to use it
func _physics_process(delta: float) -> void:
	player = $"../Leader"
	if player == null:
		return 

	# 1. Get Player's grid position
	var player_tile: Vector2i = local_to_map(to_local(player.global_position))
	
	# 2. Get the Vector2 position of your target tile
	# This gives you the center of the tile in world space
	var target_vector2: Vector2 = to_global(map_to_local(target_tile))
	
	# Optional: Calculate distance in pixels instead of tiles
	# var pixel_distance: float = player.global_position.distance_to(target_vector2)

	# 3. Your existing tile distance logic
	var distance: int = abs(player_tile.x - target_tile.x) + abs(player_tile.y - target_tile.y)

	if distance <= max_distance_in_tiles:
		print("Player is in vicinity! Target Vector2: ", target_vector2)
	else:
		print("Player too far.")   
