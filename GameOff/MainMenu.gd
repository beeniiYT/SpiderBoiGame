extends MarginContainer

onready var selector_1 = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Label
onready var selector_2 = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Label

var current_selection = 0

func _ready():
	MusicThing.Play_Music()
	set_current_selection(0)

func _process(delta):
	if Input.is_action_just_pressed("ui_down") and current_selection < 1:
		current_selection += 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_up") and current_selection > 0:
		current_selection -= 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_accept"):
		handle_selection(current_selection)
		
func handle_selection(current_selection):
		if current_selection == 0:
			get_tree().change_scene("res://other/Level_1.tscn")
			queue_free()
		elif current_selection == 1:
			get_tree().quit()
		
		
func set_current_selection(_current_selection):
	selector_1.text = ""
	selector_2.text = ""
	if _current_selection == 0:
		selector_1.text = ">"
	elif _current_selection == 1:
		selector_2.text = ">"
