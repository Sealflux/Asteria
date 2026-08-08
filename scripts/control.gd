extends Control

var rich_text_label: RichTextLabel
var duration: int
var textcount: int
var dialogueline: int = 0
var dialogue_data = [
	{
		"speaker": "Placeholder",
		"text": "Tung",
		"next_id": 1
	},
	{
		"speaker": "Placeholder",
		"text": "Tung2",
		"next_id": 2
	},
	{
		"speaker": "Placeholder",
		"text": "Tung3",
		"next_id": 3
	},
	{
		"speaker": "Placeholder",
		"text": "Sahurrrr",
		"next_id": 4
	}
]   
func _ready():
	rich_text_label = $HSplitContainer/RichTextLabel
	print(dialogue_data[1])
	print(dialogue_data[1].speaker)
	print(dialogue_data[1].text)
	print(dialogue_data[1].next_id)
	
func set_text_and_start(new_text: String):
	set_text(new_text)
	
func set_text(new_text: String):
	rich_text_label.text = new_text
	rich_text_label.visible_ratio = 0.0
	var tween = create_tween()
	textcount = rich_text_label.get_parsed_text().length()
	duration = 1 + 0.05 * textcount
	tween.tween_property($HSplitContainer/RichTextLabel, "visible_ratio", 1.0, duration).from(0.0)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if (dialogueline < dialogue_data.size()):
			set_text_and_start(dialogue_data[dialogueline].text)
			dialogueline += 1
