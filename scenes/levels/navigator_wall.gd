extends TileMapLayer

@export var player: CharacterBody2D
@export var reveal_particles: GPUParticles2D

## Maximum distance from the player to reveal wall tiles (in world pixels)
@export var reveal_radius_pixels: float = 160.0

## Average number of particles emitted per active tile per second
@export var particles_per_tile_sec: float = 8.0

## Tint/color modulation applied to emitted particles
@export var particle_color: Color = Color(1.0, 3.0, 4.0, 1.0)

## Only spawn particles on wall tiles bordering empty space
@export var edges_only: bool = true

## How often to run the particle emission check in seconds (0.05 = 20Hz).
## Keeps Physics and Process frame times low without losing visual smoothness.
@export var check_interval: float = 0.05

# Internal performance state
var _accumulated_time: float = 0.0
var _edge_tiles_cache: Dictionary = {}

func _ready() -> void:
	_verify_setup()
	rebuild_edge_cache()

func _verify_setup() -> void:
	print("--- TILEMAP REVEAL SYSTEM INITIALIZED ---")
	if not player:
		push_error("WallTileMapLayer: Player reference is MISSING in Inspector!")
	if not reveal_particles:
		push_error("WallTileMapLayer: Reveal Particles reference is MISSING in Inspector!")
	else:
		if reveal_particles.local_coords:
			print("NOTICE: 'Local Coords' on GPUParticles2D is enabled. Positions will auto-convert.")

## Call this method if you modify wall tiles dynamically during gameplay
func rebuild_edge_cache() -> void:
	_edge_tiles_cache.clear()
	var used_cells: Array[Vector2i] = get_used_cells()
	
	for coords in used_cells:
		if not _is_interior_tile(coords):
			_edge_tiles_cache[coords] = true

func _is_interior_tile(coords: Vector2i) -> bool:
	var neighbors := [
		coords + Vector2i.UP,
		coords + Vector2i.DOWN,
		coords + Vector2i.LEFT,
		coords + Vector2i.RIGHT
	]
	for n in neighbors:
		if get_cell_source_id(n) == -1:
			return false # Faces empty space; it's an edge tile
	return true # Surrounded by walls

func _physics_process(delta: float) -> void:
	if not player or not reveal_particles:
		return

	# Throttle execution to prevent Physics & Process time spikes
	_accumulated_time += delta
	if _accumulated_time >= check_interval:
		_emit_reveal_particles(_accumulated_time)
		_accumulated_time = 0.0

func _emit_reveal_particles(delta_step: float) -> void:
	var player_global_pos: Vector2 = player.global_position
	var tile_size: Vector2 = Vector2(tile_set.tile_size)
	
	# 1. Convert player global position to local tile map coordinates
	var player_local_pos: Vector2 = to_local(player_global_pos)
	var center_tile: Vector2i = local_to_map(player_local_pos)
	
	# 2. Get local bounding box radius in tile units
	var radius_tiles_x: int = int(ceil(reveal_radius_pixels / tile_size.x))
	var radius_tiles_y: int = int(ceil(reveal_radius_pixels / tile_size.y))
	var radius_sq: float = reveal_radius_pixels * reveal_radius_pixels
	
	# 3. Iterate through candidate tiles within the bounding box
	for x in range(center_tile.x - radius_tiles_x, center_tile.x + radius_tiles_x + 1):
		for y in range(center_tile.y - radius_tiles_y, center_tile.y + radius_tiles_y + 1):
			var tile_coords := Vector2i(x, y)
			
			# Check tile existence
			if get_cell_source_id(tile_coords) == -1:
				continue
				
			# Fast O(1) Dictionary edge check instead of 4 neighbor calls per frame
			if edges_only and not _edge_tiles_cache.has(tile_coords):
				continue
				
			# Convert local map position to world position
			var tile_local_pos: Vector2 = map_to_local(tile_coords)
			var tile_world_pos: Vector2 = to_global(tile_local_pos)
			
			var dist_sq: float = player_global_pos.distance_squared_to(tile_world_pos)
			
			if dist_sq <= radius_sq:
				# Scale probability by proximity
				var intensity: float = 1.0 - (dist_sq / radius_sq)
				var spawn_chance: float = particles_per_tile_sec * intensity * delta_step
				
				if randf() < spawn_chance:
					_spawn_particle_at_tile(tile_world_pos, tile_size)

func _spawn_particle_at_tile(world_pos: Vector2, tile_size: Vector2) -> void:
	# Add slight random offset inside the cell
	var offset := Vector2(
		randf_range(-tile_size.x * 0.35, tile_size.x * 0.35),
		randf_range(-tile_size.y * 0.35, tile_size.y * 0.35)
	)
	var spawn_pos: Vector2 = world_pos + offset
	
	# Correct for local_coords if enabled on GPUParticles2D
	var final_target_pos: Vector2 = spawn_pos
	if reveal_particles.local_coords:
		final_target_pos = reveal_particles.to_local(spawn_pos)
	
	var xform := Transform2D(0.0, final_target_pos)
	
	# Direct particle dispatch on GPU
	reveal_particles.emit_particle(
		xform, 
		Vector2.ZERO, 
		particle_color, 
		Color.WHITE, 
		GPUParticles2D.EMIT_FLAG_POSITION | GPUParticles2D.EMIT_FLAG_COLOR
	)
