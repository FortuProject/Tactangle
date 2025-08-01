extends State
class_name PlayerCounterGrab

@export var Player: CharacterBody2D
@export var AnimPlayer: AnimationPlayer
@export var Hurtbox_1: CollisionShape2D
@export var Hitbox_1: CollisionShape2D
@export var SFX: AudioStreamPlayer

var animation_finished = false

func grab_attempt_animation():
	AnimPlayer.play("counter_slap")
	animation_finished = false
	await AnimPlayer.animation_finished
	animation_finished = true

func Enter():
	SFX.stream = load("res://assets/audio/SFX/Move1.wav")
	SFX.play()
	await grab_attempt_animation()

func Update(delta: float):
	var move_to_state = {
		"KUZUSHI": "PlayerKuzushi",
		"GRAB": "PlayerGrab",
		"COUNTER": "PlayerCounter",
	}

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
		InputParser.current_move_sequence = []
		InputParser.exported_move = []
		state_transition.emit(self, newstate)


func _on_hitbox_area_entered(body: Area2D) -> void:
	print(body)
	if body.is_in_group("Player2"):
			print("Grab hit")
			pass
