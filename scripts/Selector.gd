extends Control
var LeaderBox
var NavigatorBox
var TrapmasterBox
var ScholarBox
signal survivor_chosen
var CurrentSurvivor
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HBoxContainer/LeaderBox/PanelContainer/PanelContainer/AnimatedSprite2D.play("idle")
	$HBoxContainer/NavigatorBox/PanelContainer/PanelContainer/AnimatedSprite2D.play("idle")
	$HBoxContainer/TrapmasterBox/PanelContainer/PanelContainer/AnimatedSprite2D2.play("idle")
	$HBoxContainer/ScholarBox/PanelContainer/PanelContainer/AnimatedSprite2D2.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_leader_box_mouse_entered() -> void:
	print("Mouse Entered LeaderBox")
	LeaderBox = $HBoxContainer/LeaderBox/PanelContainer
	
	# Create a new StyleBoxFlat resource
	var style = StyleBoxFlat.new()
	# Configure the style
	style.bg_color = Color(0.196, 0.29, 0.751, 1.0)       # Background color
	LeaderBox.add_theme_stylebox_override("panel", style)   



func _on_navigator_box_mouse_entered() -> void:
	print("Mouse Entered NavigatorBox")
	NavigatorBox = $HBoxContainer/NavigatorBox/PanelContainer
	
	# Create a new StyleBoxFlat resource
	var style = StyleBoxFlat.new()
	# Configure the style
	style.bg_color = Color(0.196, 0.29, 0.751, 1.0)       # Background color
	NavigatorBox.add_theme_stylebox_override("panel", style)  



func _on_trapmaster_box_mouse_entered() -> void:
	print("Mouse Entered TrapmasterBox")
	TrapmasterBox = $HBoxContainer/TrapmasterBox/PanelContainer
	
	# Create a new StyleBoxFlat resource
	var style = StyleBoxFlat.new()
	# Configure the style
	style.bg_color = Color(0.196, 0.29, 0.751, 1.0)       # Background color
	TrapmasterBox.add_theme_stylebox_override("panel", style)  



func _on_scholar_box_mouse_entered() -> void:
	print("Mouse Entered ScholarBox")
	ScholarBox = $HBoxContainer/ScholarBox/PanelContainer
	
	# Create a new StyleBoxFlat resource
	var style = StyleBoxFlat.new()
	# Configure the style
	style.bg_color = Color(0.196, 0.29, 0.751, 1.0)       # Background color
	ScholarBox.add_theme_stylebox_override("panel", style)  


func _on_leader_box_mouse_exited() -> void:
	print("Mouse Left LeaderBox")
	LeaderBox = $HBoxContainer/LeaderBox/PanelContainer
	
	# Create a new StyleBoxFlat resource
	var style = StyleBoxFlat.new()
	# Configure the style
	style.bg_color = Color(0.0, 0.0, 0.0, 1.0)       # Background color
	LeaderBox.add_theme_stylebox_override("panel", style)   



func _on_navigator_box_mouse_exited() -> void:
	print("Mouse Left NavigatorBox")
	NavigatorBox = $HBoxContainer/NavigatorBox/PanelContainer
	
	# Create a new StyleBoxFlat resource
	var style = StyleBoxFlat.new()
	# Configure the style
	style.bg_color = Color(0.0, 0.0, 0.0, 1.0)       # Background color
	NavigatorBox.add_theme_stylebox_override("panel", style) 

func _on_trapmaster_box_mouse_exited() -> void:
	print("Mouse Left TrapmasterBox")
	TrapmasterBox = $HBoxContainer/TrapmasterBox/PanelContainer
	
	# Create a new StyleBoxFlat resource
	var style = StyleBoxFlat.new()
	# Configure the style
	style.bg_color = Color(0.0, 0.0, 0.0, 1.0)       # Background color
	TrapmasterBox.add_theme_stylebox_override("panel", style)  
	

func _on_scholar_box_mouse_exited() -> void:
	print("Mouse Left ScholarBox")
	ScholarBox = $HBoxContainer/ScholarBox/PanelContainer
	
	# Create a new StyleBoxFlat resource
	var style = StyleBoxFlat.new()
	# Configure the style
	style.bg_color = Color(0.0, 0.0, 0.0, 1.0)       # Background color
	ScholarBox.add_theme_stylebox_override("panel", style)  
	

func _on_leader_box_gui_input(event: InputEvent) -> void:
	# Check if the event is a left mouse button press
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		# Prevent the event from propagating to other nodes (e.g., items behind this box)
		get_viewport().set_input_as_handled()
		
		print("LeaderBox Clicked")
		# Instantiate and reparent the new survivor
		var CurrentSurvivor = preload("res://scenes/Leader.tscn")
		var NewSurvivor = CurrentSurvivor.instantiate()
		
		# Ensure the parent path exists before reparenting
		var parent_node = get_node_or_null("../..")
		NewSurvivor.position = Vector2(-221.0,-55) 
		if parent_node:
			parent_node.add_child(NewSurvivor)
			NewSurvivor.position = Vector2(-221.0,-55) 
			print("Added Survivor")
		call_deferred("queue_free")


func _on_navigator_box_gui_input(event: InputEvent) -> void:
	# Check if the event is a left mouse button press
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		# Prevent the event from propagating to other nodes (e.g., items behind this box)
		get_viewport().set_input_as_handled()
		
		print("Navigator Clicked")
		# Instantiate and reparent the new survivor
		var CurrentSurvivor = preload("res://scenes/Navigator.tscn")
		var NewSurvivor = CurrentSurvivor.instantiate()
		
		# Ensure the parent path exists before reparenting
		var parent_node = get_node_or_null("../..")
		NewSurvivor.position = Vector2(-221.0,-55) 
		if parent_node:
			parent_node.add_child(NewSurvivor)
			NewSurvivor.position = Vector2(-221.0,-55) 
			print("Added Survivor")
		call_deferred("queue_free")


func _on_trapmaster_box_gui_input(event: InputEvent) -> void:
	# Check if the event is a left mouse button press
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		# Prevent the event from propagating to other nodes (e.g., items behind this box)
		get_viewport().set_input_as_handled()
		
		print("Trapmaster Clicked")
		# Instantiate and reparent the new survivor
		var CurrentSurvivor = preload("res://scenes/Trapmaster.tscn")
		var NewSurvivor = CurrentSurvivor.instantiate()
		
		# Ensure the parent path exists before reparenting
		var parent_node = get_node_or_null("../..")
		NewSurvivor.position = Vector2(-221.0,-55) 
		if parent_node:
			parent_node.add_child(NewSurvivor)
			NewSurvivor.position = Vector2(-221.0,-55) 
			print("Added Survivor")
		call_deferred("queue_free")


func _on_scholar_box_gui_input(event: InputEvent) -> void:
	# Check if the event is a left mouse button press
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		# Prevent the event from propagating to other nodes (e.g., items behind this box)
		get_viewport().set_input_as_handled()
		
		print("Scholar Clicked")
		# Instantiate and reparent the new survivor
		var CurrentSurvivor = preload("res://scenes/Scholar.tscn")
		var NewSurvivor = CurrentSurvivor.instantiate()
		
		# Ensure the parent path exists before reparenting
		var parent_node = get_node_or_null("../..")
		NewSurvivor.position = Vector2(-221.0,-55) 
		if parent_node:
			parent_node.add_child(NewSurvivor)
			NewSurvivor.position = Vector2(-221.0,-55) 
			print("Added Survivor")
		call_deferred("queue_free")
