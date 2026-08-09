extends Control

var label: Label
var animated_sprite: AnimatedSprite2D
var duration: int
var textcount: int
var dialogueline: int = 0
var base_font_size : int
var base_size : Vector2
var dialoguebox: CanvasLayer
var dialogue_data = [
	{
		"speaker": "Placeholder",
		"text": "So the story will take place on a campground site, in the forest. It will be dark, and the player plays as a group of survivors. Each level you will start with a certain number of survivors. You will be dying to traps in a maze, with invisible walls. You are able to see the floor near you with your small lantern range, but no walls. Traps may or may not be hidden, but when the survivor triggers a trap, their lantern spills and lights up the walls/traps next is a greater radius. Then you play as the next survivor, but remember the number of available survivors is limited.",
		"next_id": 1
	},
	{
		"speaker": "Placeholder",
		"text": "Tung",
		"next_id": 2
	},
	{
		"speaker": "Placeholder",
		"text": "Tung",
		"next_id": 3
	},
	{
		"speaker": "Placeholder",
		"text": "Sahurrrr",
		"next_id": 4
	}
]   
func _ready():
	label = $HBoxContainer/Label
	animated_sprite = $HBoxContainer/PanelContainer/AnimatedSprite2D
	dialoguebox = $".."
	print(dialogue_data[1])
	print(dialogue_data[1].speaker)
	print(dialogue_data[1].text)
	print(dialogue_data[1].next_id)
	
var tween: Tween

func type_text(new_text: String) -> void:
	# Cancel any ongoing typing
	if tween and tween.is_valid():
		tween.kill()
	
	label.text = new_text
	label.visible_characters = 0
	
	var total_chars = label.get_total_character_count()
	print(total_chars)
	var char_wait_time = 0.05 # 0.05s per character
	
	tween = create_tween()
	
	# Loop through each character
	for i in range(total_chars):
		# Reveal one character
		label.visible_characters = i + 1

		play_sound("res://assets/sans.wav")
		
		# Wait before next character (unless it's the last one)
		if i < total_chars - 1:
			await get_tree().create_timer(char_wait_time).timeout   
func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if (dialogueline < dialogue_data.size()):
			type_text(dialogue_data[dialogueline].text)
			$HBoxContainer/PanelContainer/AnimatedSprite2D.play("idle")
			dialogueline += 1
		if (dialogueline == dialogue_data.size()):
			dialoguebox.queue_free()
			dialogueline = 0
			
func play_sound(path: String) -> void:
	var player = AudioStreamPlayer.new()
	add_child(player) # Add to scene tree
	
	player.stream = load(path)
	player.volume_db = -5 # Optional: lower volume slightly to prevent clipping when many play
	
	player.play()
	
	# Connect to the 'finished' signal to clean up
	player.finished.connect(func():
		player.queue_free() # Remove the node when sound is done
	)


func set_text_size():
	var new_size = $".".size
	
	# scale base on control width
	var scale = new_size.x / base_size.x
	var scaled_size :int= floor(base_font_size * scale)

	# bitmap cannot be greater than 4096
	if scaled_size>4096:
		return
	
	# apply scale
	label.add_theme_font_size_override("font_size", scaled_size)
