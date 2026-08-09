extends Node2D

# Drag and drop your target scene from the FileSystem dock into this slot in the Inspector
@export var target_scene: PackedScene

func _unhandled_input(event: InputEvent) -> void:
	# Checks if the event is a key press, specifically the 'C' key, and not a repeat echo
	if event is InputEventKey and event.pressed and not event.is_echo():
		if event.keycode == KEY_C:
			# Ensure a scene was actually assigned in the Inspector before switching
			if target_scene:
				get_tree().change_scene_to_file(target_scene.resource_path)
			else:
				push_warning("Target scene is not assigned in the Inspector!")
