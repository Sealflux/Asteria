extends Node
var Survivor_Spawn: PackedScene
var Lantern_Spawn: PackedScene
var Current_Survivor
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var Trap = get_node("SimpleTrap")
	Trap.survivor_died.connect(_on_survivor_died)
	Trap.spawn_survivor.connect(_on_spawn_survivor)

func spawn_Survivor(survivor : int, position: Vector2):
	# 2. Instantiate the scene
	if survivor == 1:
		Survivor_Spawn = preload("res://scenes/Leader.tscn")
	#if survivor == 2:
	#	Survivor_Spawn = preload("res://scenes/Trapmaster.tscn")
	#if survivor == 3:
	#	Survivor_Spawn = preload("res://scenes/Navigator.tscn")
	#if survivor == 4:
	#	Survivor_Spawn = preload("res://scenes/Scholar.tscn")
	var CurrentSurvivor = Survivor_Spawn.instantiate()
	CurrentSurvivor.position = position
	add_child(CurrentSurvivor)

#func spawn_Lantern(position: Vector2):
	#Lantern_Spawn = preload("res://scenes/Lantern.tscn")
	#var NewLantern = Lantern_Spawn.instantiate()
	#NewLantern.position = position
	#add_child(NewLantern) 

func _on_spawn_survivor(survivor: int, position: Vector2) -> void:
	spawn_Survivor(survivor, position)
	


func _on_survivor_died(Survivor) -> void:
	print("Death")
	Survivor.queue_free()
	#spawn_Lantern(position)
