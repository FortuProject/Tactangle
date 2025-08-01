extends State
class_name PlayerIdle

@export var Player: CharacterBody2D
@export var AnimPlayer: AnimationPlayer
@export var Hurtbox_1: CollisionShape2D
@export var Hitbox_1: CollisionShape2D
@export var SFX: AudioStreamPlayer
var animation_finished = false

func check_self_state(): 
	#print("[PlayerIdle] check_self_state() called")
	return true


func idle_animation(): 
	#print("[PlayerIdle] Starting idle animation")
	AnimPlayer.speed_scale = 0.3
	AnimPlayer.play("idle")
	animation_finished = false
	await AnimPlayer.animation_finished
	#print("[PlayerIdle] Idle animation finished")
	animation_finished = true


func Enter():
	InputParser.current_move_sequence = []
	InputParser.exported_move = []
	#print("[PlayerIdle] Enter() called")
	AnimPlayer.speed_scale = 0.3
	AnimPlayer.play("idle")
	animation_finished = false


func Update(delta: float):
	#print("[PlayerIdle] Update() called. Animation playing:", AnimPlayer.is_playing(), " | Finished:", animation_finished)

	#if not AnimPlayer.is_playing() and not animation_finished:
		#print("[PlayerIdle] Detected idle animation stopped.")
		#animation_finished = true

	#if animation_finished:
	#print("[PlayerIdle] Checking input for state transition.")
	#print("    current_move_sequence:", InputParser.current_move_sequence)
	#print("    exported_move:", InputParser.exported_move)

	var move_to_state = {
		"RIGHT": "PlayerWalking_Dash",
		"GRAB": "PlayerGrab",
		"KUZUSHI": "PlayerKuzushi",
		"THROW": "PlayerThrow",
		"LEFT": "PlayerWalking_Dash",
		"GRAB_SPECIAL": "PlayerSuperGrab",
		"KUZUSHI_SPECIAL": "PlayerSuperKuzushi",
		"THROW_SPECIAL": "PlayerSuperThrow",
		"GRAB_COUNTER": "PlayerCounterGrab",
		"KUZUSHI_COUNTER": "PlayerCounterKuzushi",
		"THROW_COUNTER": "PlayerCounterThrow"
		}

	for move in move_to_state.keys():
		if InputParser.current_move_sequence.has(move) or str(InputParser.exported_move) == move:
			var next_state = move_to_state[move]
			InputParser.current_move_sequence = []
			InputParser.exported_move = []
			Transition(next_state)
			return
		#print("[PlayerIdle] No valid move found, resetting input and returning to PlayerIdle.")
		#Transition("PlayerIdle")


func Transition(newstate : String):
	#print("[PlayerIdle] Transition() called →", newstate)
	state_transition.emit(self, newstate)


func _on_hurtbox_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	#print("[PlayerIdle] Hurtbox triggered - taking damage from:", area.name)
	pass


func _on_hitbox_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	#print("[PlayerIdle] Hitbox triggered - dealing damage to:", area.name)
	pass

func Exit():
	#print("[PlayerIdle] Exit() called")
	AnimPlayer.speed_scale = 1
	InputParser.current_move_sequence = []
	InputParser.exported_move = []
