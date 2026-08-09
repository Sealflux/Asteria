extends CharacterBody2D

@export var SPEED = 400
@export var check_interval: float = 0.1

var screen_size
var _all_traps: Array[Trap] = []
var _accumulated_time := 0.0
var _is_alert := false

func _ready() -> void:
	screen_size = get_viewport_rect().size
	_all_traps = _find_all_traps(get_tree().root)

func _physics_process(delta: float) -> void:
	# --- Movement ---
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_dir * SPEED

	if input_dir.length() > 0:
		if not _is_alert:
			$AnimatedSprite2D.play("walk")
		if input_dir.x != 0:
			$AnimatedSprite2D.flip_h = input_dir.x < 0
	else:
		if not _is_alert:
			$AnimatedSprite2D.play("idle")

	move_and_slide()

	# --- Trap detection (throttled) ---
	_accumulated_time += delta
	if _accumulated_time >= check_interval:
		_check_traps_on_screen()
		_accumulated_time = 0.0

func _find_all_traps(node: Node) -> Array[Trap]:
	var found: Array[Trap] = []
	if node is Trap:
		found.append(node as Trap)
	for child in node.get_children():
		found.append_array(_find_all_traps(child))
	return found

func _check_traps_on_screen() -> void:
	var cam := get_viewport().get_camera_2d()
	if not cam:
		return

	var visible_rect := _get_camera_world_rect(cam)

	var any_visible := false
	for trap in _all_traps:
		if not is_instance_valid(trap):
			continue
		if visible_rect.has_point(trap.global_position):
			any_visible = true
			break

	if any_visible != _is_alert:
		_is_alert = any_visible
		_update_alert_state()

func _get_camera_world_rect(cam: Camera2D) -> Rect2:
	var viewport_size := get_viewport_rect().size
	var zoom := cam.zoom
	var size := viewport_size / zoom
	var top_left := cam.global_position - size * 0.5
	return Rect2(top_left, size)

func _update_alert_state() -> void:
	if _is_alert:
		$AnimatedSprite2D.play("alert")
	else:
		# resume normal walk/idle immediately based on current input
		if velocity.length() > 0:
			$AnimatedSprite2D.play("walk")
		else:
			$AnimatedSprite2D.play("idle")
