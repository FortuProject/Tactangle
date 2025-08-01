extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match Global.CharacterSelectType:
		"Training":
			if Input.is_action_just_pressed("GRAB") or Input.is_action_just_pressed("KUZUSHI") or  Input.is_action_just_pressed("THROW"):
				get_tree().change_scene_to_file("")
				InputParser.DisabledFunction = false
			elif Input.is_action_just_pressed("COUNTER_GRAB") or Input.is_action_just_pressed("COUNTER_KUZUSHI") or  Input.is_action_just_pressed("COUNTER_THROW"):
				get_tree().change_scene_to_file("res://scenes/Pre_Post_Game/FGC_MENU.tscn")
				InputParser.DisabledFunction = false
		"Versus":
			if Input.is_action_just_pressed("GRAB") or Input.is_action_just_pressed("KUZUSHI") or  Input.is_action_just_pressed("THROW"):
				get_tree().change_scene_to_file("res://scenes/Footsies.tscn")
				InputParser.DisabledFunction = false
			elif Input.is_action_just_pressed("COUNTER_GRAB") or Input.is_action_just_pressed("COUNTER_KUZUSHI") or  Input.is_action_just_pressed("COUNTER_THROW"):
				get_tree().change_scene_to_file("res://scenes/Pre_Post_Game/FIGHT_MENU.tscn")
				InputParser.DisabledFunction = false
		"Arcade":
			if Input.is_action_just_pressed("GRAB") or Input.is_action_just_pressed("KUZUSHI") or  Input.is_action_just_pressed("THROW"):
				get_tree().change_scene_to_file("res://scenes/Footsies.tscn")
				InputParser.DisabledFunction = false
			elif Input.is_action_just_pressed("COUNTER_GRAB") or Input.is_action_just_pressed("COUNTER_KUZUSHI") or  Input.is_action_just_pressed("COUNTER_THROW"):
				get_tree().change_scene_to_file("res://scenes/Pre_Post_Game/FIGHT_MENU.tscn")
				InputParser.DisabledFunction = false
		"Tournament":
			if Input.is_action_just_pressed("GRAB") or Input.is_action_just_pressed("KUZUSHI") or  Input.is_action_just_pressed("THROW"):
				get_tree().change_scene_to_file("res://scenes/Footsies.tscn")
				InputParser.DisabledFunction = false
			elif Input.is_action_just_pressed("COUNTER_GRAB") or Input.is_action_just_pressed("COUNTER_KUZUSHI") or  Input.is_action_just_pressed("COUNTER_THROW"):
				get_tree().change_scene_to_file("res://scenes/Pre_Post_Game/FIGHT_MENU.tscn")
				InputParser.DisabledFunction = false
	
