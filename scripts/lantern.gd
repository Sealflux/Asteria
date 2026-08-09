extends Area2D

func _ready() -> void:
	var wall_layer = get_node("/root/Level1/WallTileMapLayer")
	print("wall_layer found: ", wall_layer)
	if wall_layer:
		wall_layer.register_reveal_source(func(): return global_position, $RevealParticles)
		print("registered reveal source")
