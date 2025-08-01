extends State
class_name PlayerKuzushi
@export var Player: CharacterBody2D
@export var AnimPlayer: AnimationPlayer
@export var Hurtbox_1: CollisionShape2D
@export var Hitbox_1: CollisionShape2D
@export var SFX: AudioStreamPlayer 
var animation_finished = false

func kuzushi_attempt_animation(): 
	animation_finished = true
	# End any other animations currently being played? 
	AnimPlayer.play("kuzushi")
	animation_finished = false
	await AnimPlayer.animation_finished
	animation_finished = true
	return
	# Play the animation, wait for it to finish. 
	# Possible error, moves can be canceled into other moves, meaning this script gets cut off. 
	# Possible error, the idle animation loops. 

func Enter(): 
	InputParser.current_move_sequence = []
	InputParser.exported_move = []
	SFX.stream = load("res://assets/audio/SFX/Move1.wav")
	SFX.play()
	#print("Grip attempt started.")
	kuzushi_attempt_animation()

func Update(delta: float):
	var move_to_state = {
			"THROW_P2": "PlayerThrow",
			"THROW_SPECIAL_P2": "PlayerSuperThrow"
	}
	
	if AnimPlayer.is_playing() and AnimPlayer.current_animation != "Super_Kuzushi":
		# Don't transition if another animation is playing (e.g., leftover)
		return
		
	if animation_finished:
		# Check for any matching move in current_move_sequence
		for move in move_to_state.keys():
			if InputParser.current_move_sequence.has(move) or str(InputParser.exported_move) == move:
				Transition(move_to_state[move])
				return
	
		# If no move matches, go back to idle
		InputParser.current_move_sequence.clear()
		InputParser.direction_history.clear()
		Transition("PlayerIdle")
	
	

func Transition(newstate : String):
		state_transition.emit(self, newstate)

func Exit():
	InputParser.current_move_sequence = []
	InputParser.exported_move = []
