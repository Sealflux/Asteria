extends Control
var LeaderBox
var NavigatorBox
var TrapmasterBox
var ScholarBox
signal SpawnSurvivor

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


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
	if event is InputEventMouseButton and event.is_pressed():
		print("LeaderBox Clicked")
		self.queue_free()
		SpawnSurvivor.emit(1, Vector2(0,0))
		
