extends State
class_name PlayerThrow
@export var Player: CharacterBody2D
@export var AnimPlayer: AnimationPlayer
@export var Hurtbox_1: CollisionShape2D
@export var Hitbox_1: CollisionShape2D
@export var SFX: AudioStreamPlayer 
var animation_finished = false

func throw_attempt_animation(): 
	AnimPlayer.play("throw")
	animation_finished = false
	await AnimPlayer.animation_finished
	animation_finished = true


func Enter(): 
	SFX.stream = load("res://assets/audio/SFX/Move1.wav")
	SFX.play()
	#print("Grip attempt started.")
	await throw_attempt_animation()

func Update(delta: float):
	var move_to_state = {
		"RIGHT_P2": "PlayerWalking_Dash",
		"LEFT_P2": "PlayerWalking_Dash",
	}
	#elif Input.is_action_just_pressed("RIGHT"):
		#Transition("PlayerWalkForward")
	#elif Input.is_action_just_pressed("LEFT"):
		#Transition("PlayerWalkBack")
	#if Input.is_action_just_pressed("DOWN"):
		#Transition("PlayerDown")
	#elif Input.is_action_just_pressed("KUZUSHI"):
		#Transition("PlayerKuzushi")
	#if AnimPlayer.animation_finished:
		#Transition("PlayerIdle")
	
	# If animation is done, check transitions
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
