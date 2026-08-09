class_name Trap
extends Area2D
signal survivor_died
signal spawn_survivor
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	
func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		print("ow")
		# damage/kill
		survivor_died.emit(body)
		spawn_survivor.emit(1,Vector2(0,0))
		
