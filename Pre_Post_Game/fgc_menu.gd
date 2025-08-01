extends Control

## Volume Settings
#Global.Musik_Band = Global.Musik_Band+10
	#Global.DialogBand = Global.DialogBand+10
	#audio_player.set_volume_db(Global.SoundeffeketeBand)
	#audio_player_2.set_volume_db(Global.Musik_Band)


var pointer_locations = [  # Corrected the syntax for the list
	Vector2(290, 196),
	Vector2(296, 306),
	Vector2(302, 396),
	Vector2(340, 493)
]
@onready var SFX = $SFX
@onready var Pointer = $Pointer
@onready var pointer_index = 0
@onready var MenuNum = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Pointer.position = pointer_locations[pointer_index]
	switch_backgrounds()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void: 
	if Input.is_action_just_pressed("RIGHT"):
		Input.is_action_just_pressed("UP")
	elif Input.is_action_just_pressed("LEFT"):
		Input.is_action_just_pressed("DOWN")
	elif Input.is_action_just_pressed("UP"):
		var locations = pointer_locations
		if pointer_index > 0:
			pointer_index -= 1
			Pointer.position = locations[pointer_index]
			SFX.stream = load("res://assets/audio/SFX/Move1.wav")
			SFX.play()
	elif Input.is_action_just_pressed("DOWN"):
		var locations = pointer_locations
		if pointer_index < locations.size() - 1:
			pointer_index += 1
			Pointer.position = locations[pointer_index]
			SFX.stream = load("res://assets/audio/SFX/Move1.wav")
			SFX.play()
	elif Input.is_action_just_pressed("GRAB"): 
		match pointer_index:
			0: # FIGHT 
				SFX.stream = load("res://assets/audio/SFX/Capture1.wav")
				SFX.play()
				get_tree().change_scene_to_file("res://scenes/Pre_Post_Game/FIGHT_MENU.tscn")
			1: # Training
				SFX.stream = load("res://assets/audio/SFX/Capture1.wav")
				SFX.play()
				get_tree().change_scene_to_file("res://scenes/Pre_Post_Game/CharacterSelect.tscn")
			2: # Extras
				SFX.stream = load("res://assets/audio/SFX/Capture1.wav")
				SFX.play()
				
			3: # Settings
				SFX.stream = load("res://assets/audio/SFX/Capture1.wav")
				SFX.play()
				
func switch_backgrounds() -> void:
	while true:
		match MenuNum:
			0:
				$Background_MainMenu.show()
				$Background_MainMenu2.hide()
				$Background_MainMenu3.hide()
				MenuNum = 1
			1:
				$Background_MainMenu.hide()
				$Background_MainMenu2.show()
				$Background_MainMenu3.hide()
				MenuNum = 2
			2:
				$Background_MainMenu.hide()
				$Background_MainMenu2.hide()
				$Background_MainMenu3.show()
				MenuNum = 0

		await get_tree().create_timer(5.0).timeout
