extends CharacterBody2D

@export var SPEED = 400
var screen_size


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size



func _physics_process(delta: float) -> void:
	# Get input direction (Vector2)
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Set velocity and move safely against walls
	velocity = input_dir * SPEED
	move_and_slide()
