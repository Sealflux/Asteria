extends Node2D
var Survivor_Spawn: PackedScene
var Lantern_Spawn: PackedScene
var Current_Survivor
var DialogueBox
var SelectSurvivor
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(11):
		var node_path = "SimpleTrap" + str(i)
		# Check if node exists before accessing to avoid errors
		if has_node(node_path):
			var trap_node = get_node(node_path)
			trap_node.survivor_died.connect(_on_survivor_died)
			trap_node.spawn_survivor.connect(_spawn_Survivor)

func _spawn_Survivor():
	SelectSurvivor = preload("res://scenes/Selector.tscn")
	if has_node("Selector") == null:
		var NewSelectScreen = SelectSurvivor.instantiate()
		add_child(NewSelectScreen)
func _on_survivor_died(Survivor) -> void:
	print("Death")
	Survivor.queue_free()
	spawn_Lantern(Survivor.position)
	spawn_Lantern(Vector2i(96,96))
	if $Control:
		$Control.queue_free()
	else:
		ShowDialogue()
func ShowDialogue():
	DialogueBox = preload("res://scenes/Selector.tscn")
	var NewDialogueBox = DialogueBox.instantiate()
	add_child(NewDialogueBox)

func spawn_Lantern(positioncoords: Vector2):
	Lantern_Spawn = preload("res://scenes/Lantern.tscn")
	var NewLantern = Lantern_Spawn.instantiate()
	NewLantern.position = positioncoords
	add_child(NewLantern)
