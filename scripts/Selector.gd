extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var LeaderBox = get_node("HBoxContainer/LeaderBox")
	var NavigatorBox = get_node("HBoxContainer/NavigatorBox")
	var TrapmasterBox = get_node("HBoxContainer/TrapmasterBox")
	var ScholarBox = get_node("HBoxContainer/ScholarBox")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_leader_box_mouse_entered() -> void:
	print("Mouse Entered LeaderBox")
	


func _on_navigator_box_mouse_entered() -> void:
	print("Mouse Entered NavigatorBox")



func _on_trapmaster_box_mouse_entered() -> void:
	print("Mouse Entered TrapmasterBox")



func _on_scholar_box_mouse_entered() -> void:
	print("Mouse Entered ScholarBox")
