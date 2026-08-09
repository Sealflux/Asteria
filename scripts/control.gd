extends Control

var label: Label
var animated_sprite: AnimatedSprite2D
var duration: int
var textcount: int
var dialogueline: int = 0
var base_font_size : int
var base_size : Vector2
var dialogue_data = [
	{
		"speaker": "Placeholder",
		"text": "Tung Tung Tung Sahur",
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
	label = $HSplitContainer/Label
	animated_sprite = $HSplitContainer/PanelContainer/AnimatedSprite2D
	print(dialogue_data[1])
	print(dialogue_data[1].speaker)
	print(dialogue_data[1].text)
	print(dialogue_data[1].next_id)
	
func type_text(new_text: String):
	var tween = create_tween()
	label.text = new_text
	# Calculate time based on length for consistent speed (e.g., 0.05s per char)
	var time = new_text.length() * 0.05
	tween.tween_property(label, "visible_characters", new_text.length(), time)
	tween.tween_interval(0.05) # Pause before repeating or ending
	play_sound("res://assets/sans.wav")
	tween.tween_property(label, "visible_characters", 0, 0.2) # Optional: fade out to repeat   


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if (dialogueline < dialogue_data.size()):
			type_text(dialogue_data[dialogueline].text)
			$HSplitContainer/PanelContainer/AnimatedSprite2D.play("idle")
			dialogueline += 1
			
@onready var audio_player = $AudioStreamPlayer2D

func play_sound(path):
	audio_player.stream = load(path)
	audio_player.play()   


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
