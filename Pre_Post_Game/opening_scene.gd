extends Control

@onready var MusikAudio = $MusikAudio
@onready var SoundEffekete = $Soundeffekete
@onready var DialogAudio = $Dialoge

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MusikAudio.set_volume_db(Global.Musik_Band)
	SoundEffekete.set_volume_db(Global.SoundeffeketeBand)
	DialogAudio.set_volume_db(Global.DialogBand)
	pass # Replace with function body.


## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("GRAB"):
		get_tree().change_scene_to_file("res://scenes/Pre_Post_Game/FGC_MENU.tscn")

func _on_video_stream_player_finished() -> void:
	get_tree().change_scene_to_file("res://scenes/Pre_Post_Game/FGC_MENU.tscn")
	pass # Replace with function body.
