extends TileMapLayer

@export var player: CharacterBody2D
@export var reveal_particles: GPUParticles2D

@export var reveal_radius_pixels: float = 160.0
@export var particles_per_tile_sec: float = 8.0
@export var particle_color: Color = Color(1.0, 3.0, 4.0, 1.0)
@export var edges_only: bool = true
@export var check_interval: float = 0.05

var _accumulated_time: float = 0.0
var _edge_tiles_cache: Dictionary = {}

# Each entry: { "get_pos": Callable, "particles": GPUParticles2D }
var _reveal_sources: Array = []

func _find_target_and_particles() -> void:
	if not player:
		if has_node("%Navigator"):
			var node = get_node("%Navigator")
			if node is CharacterBody2D:
				player = node as CharacterBody2D
		if not player:
			player = _find_child_by_name_and_type(get_tree().root, "Navigator")

	if player and not reveal_particles:
		for child in player.get_children():
			if child is GPUParticles2D:
				reveal_particles = child as GPUParticles2D
				break

func _find_child_by_name_and_type(node: Node, target_name: String) -> CharacterBody2D:
	if node.name == target_name and node is CharacterBody2D:
		return node as CharacterBody2D
	for child in node.get_children():
		var found = _find_child_by_name_and_type(child, target_name)
		if found:
			return found
	return null

func _verify_setup() -> void:
	print("--- TILEMAP REVEAL SYSTEM INITIALIZED ---")
	if not player:
		push_error("WallTileMapLayer: Player reference is MISSING in Inspector!")
	if not reveal_particles:
		push_error("WallTileMapLayer: Reveal Particles reference is MISSING in Inspector!")
	else:
		if reveal_particles.local_coords:
			print("NOTICE: 'Local Coords' on GPUParticles2D is enabled. Positions will auto-convert.")

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
			return false
	return true
	
	
func _ready() -> void:
	_find_target_and_particles()
	_verify_setup()
	rebuild_edge_cache()
	if player and reveal_particles:
		register_reveal_source(func(): return player.global_position, reveal_particles)

## Call this from anywhere (e.g. Lantern's _ready) to make something else reveal walls
func register_reveal_source(get_pos: Callable, particles: GPUParticles2D) -> void:
	_reveal_sources.append({"get_pos": get_pos, "particles": particles})

func unregister_reveal_source(particles: GPUParticles2D) -> void:
	_reveal_sources = _reveal_sources.filter(func(s): return s["particles"] != particles)

# ... (_find_target_and_particles, _find_child_by_name_and_type, _verify_setup, rebuild_edge_cache, _is_interior_tile unchanged) ...

func _physics_process(delta: float) -> void:
	if _reveal_sources.is_empty():
		return
	_accumulated_time += delta
	if _accumulated_time >= check_interval:
		for source in _reveal_sources:
			if is_instance_valid(source["particles"]):
				_emit_reveal_particles_for_source(source["get_pos"].call(), source["particles"], _accumulated_time)
		_accumulated_time = 0.0

func _emit_reveal_particles_for_source(source_global_pos: Vector2, particles: GPUParticles2D, delta_step: float) -> void:
	var tile_size: Vector2 = Vector2(tile_set.tile_size)
	var source_local_pos: Vector2 = to_local(source_global_pos)
	var center_tile: Vector2i = local_to_map(source_local_pos)

	var radius_tiles_x: int = int(ceil(reveal_radius_pixels / tile_size.x))
	var radius_tiles_y: int = int(ceil(reveal_radius_pixels / tile_size.y))
	var radius_sq: float = reveal_radius_pixels * reveal_radius_pixels

	for x in range(center_tile.x - radius_tiles_x, center_tile.x + radius_tiles_x + 1):
		for y in range(center_tile.y - radius_tiles_y, center_tile.y + radius_tiles_y + 1):
			var tile_coords := Vector2i(x, y)
			if get_cell_source_id(tile_coords) == -1:
				continue
			if edges_only and not _edge_tiles_cache.has(tile_coords):
				continue

			var tile_local_pos: Vector2 = map_to_local(tile_coords)
			var tile_world_pos: Vector2 = to_global(tile_local_pos)
			var dist_sq: float = source_global_pos.distance_squared_to(tile_world_pos)

			if dist_sq <= radius_sq:
				var intensity: float = 1.0 - (dist_sq / radius_sq)
				var spawn_chance: float = particles_per_tile_sec * intensity * delta_step
				if randf() < spawn_chance:
					_spawn_particle_at_tile(tile_world_pos, tile_size, particles)

func _spawn_particle_at_tile(world_pos: Vector2, tile_size: Vector2, particles: GPUParticles2D) -> void:
	var offset := Vector2(
		randf_range(-tile_size.x * 0.35, tile_size.x * 0.35),
		randf_range(-tile_size.y * 0.35, tile_size.y * 0.35)
	)
	var spawn_pos: Vector2 = world_pos + offset
	var final_target_pos: Vector2 = spawn_pos
	if particles.local_coords:
		final_target_pos = particles.to_local(spawn_pos)
	var xform := Transform2D(0.0, final_target_pos)
	particles.emit_particle(
		xform,
		Vector2.ZERO,
		particle_color,
		Color.WHITE,
		GPUParticles2D.EMIT_FLAG_POSITION | GPUParticles2D.EMIT_FLAG_COLOR
	)
