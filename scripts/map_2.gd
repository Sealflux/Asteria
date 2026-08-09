extends Node2D
var Survivor_Spawn: PackedScene
var Lantern_Spawn: PackedScene
var Current_Survivor
var DialogueBox
var SelectSurvivor
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var Trap = get_node("SimpleTrap")
	Trap.survivor_died.connect(_on_survivor_died)
	Trap.spawn_survivor.connect(_spawn_Survivor)
	var Trap2 = get_node("SimpleTrap2")
	Trap2.survivor_died.connect(_on_survivor_died)
	Trap2.spawn_survivor.connect(_spawn_Survivor)
	var Trap3 = get_node("SimpleTrap3")
	Trap3.survivor_died.connect(_on_survivor_died)
	Trap3.spawn_survivor.connect(_spawn_Survivor)
	var Trap4 = get_node("SimpleTrap4")
	Trap4.survivor_died.connect(_on_survivor_died)
	Trap4.spawn_survivor.connect(_spawn_Survivor)
	var Trap5 = get_node("SimpleTrap5")
	Trap5.survivor_died.connect(_on_survivor_died)
	Trap5.spawn_survivor.connect(_spawn_Survivor)
	var Trap6 = get_node("SimpleTrap6")
	Trap6.survivor_died.connect(_on_survivor_died)
	Trap6.spawn_survivor.connect(_spawn_Survivor)
	var Trap7 = get_node("SimpleTrap7")
	Trap7.survivor_died.connect(_on_survivor_died)
	Trap7.spawn_survivor.connect(_spawn_Survivor)
	var Trap8 = get_node("SimpleTrap8")
	Trap8.survivor_died.connect(_on_survivor_died)
	Trap8.spawn_survivor.aconnect(_spawn_Survivor)
	var Trap9 = get_node("SimpleTrap9")
	Trap9.survivor_died.connect(_on_survivor_died)
	Trap9.spawn_survivor.connect(_spawn_Survivor)
	

func _spawn_Survivor():
	SelectSurvivor = preload("res://scenes/Selector.tscn")
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
