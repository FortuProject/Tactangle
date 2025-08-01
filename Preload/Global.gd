extends Node

@onready var Master_Band = -50
@onready var Musik_Band = -50
@onready var DialogBand = -50
@onready var SoundeffeketeBand = -20

#@onready var Player_Location = Vector2(240, 255)
#@onready var Enemy_Location = Vector2(240, 255) 
@onready var Buttons_Disabled = false
@onready var CharacterSelectType = "Training"
@onready var Player_One = {
	"User" : "Player",
	"Character" : "Kreiger",
	"OST": "res://assets/audio/LukHash - Chiptune Ride.mp3"
}

@onready var Player_Two = {
	"User" : "AI",
	"Character" : "Kreiger",
	"OST": "res://assets/audio/LukHash - Chiptune Ride.mp3"
}

# Save slot variables
var Current_Game_Save_Slot: String =  ""
# Called when the node enters the scene tree
func _ready():
	# Load save slot information when the game starts
	load_save_slots()


# Function to initialize save slots
func load_save_slots():
	#Player_1_name = _load_save_slot("user://json/Save_1_information.json")
	#Player_2_name = _load_save_slot("user://json/Save_2_information.json")
	#Player_3_name = _load_save_slot("user://json/Save_3_information.json")
	pass

# Helper function to load a single save slot
func _load_save_slot(file_path: String) -> String:
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file:
		var json_data = file.get_as_text()
		file.close()
		
		# Create an instance of the JSON class
		var json = JSON.new()
		
		# Parse the JSON data
		var error = json.parse(json_data)
		if error == OK:
			var data = json.get_data()
			if data and data.has("Save_Slot") and data["Save_Slot"].has("name"):
				return data["Save_Slot"]["name"]
			else:
				print("Missing 'Save_Slot' or 'name' field in JSON data: ", file_path)
		else:
			print("Failed to parse JSON: ", json.get_error_message(), " in file: ", file_path)
	else:
		print("Save file not found: ", file_path)
	
	# Return an empty string if the file doesn't exist or parsing fails
	return ""
