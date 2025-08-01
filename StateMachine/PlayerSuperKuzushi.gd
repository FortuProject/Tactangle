extends State
class_name PlayerSuperKuzushi
@export var Player: CharacterBody2D
@export var AnimPlayer: AnimationPlayer
@onready var Best_Move = AI.BestMove("EnemyGrab")
@export var Hurtbox_1: CollisionShape2D
@export var Hitbox_1: CollisionShape2D
@export var SFX: AudioStreamPlayer 
var animation_finished = false
var already_entered = false
#@onready var Grabs = $"../../Hitbox/Grabs"

func grab_attempt_animation(): 
	AnimPlayer.play("Super_Kuzushi")
	animation_finished = false
	await AnimPlayer.animation_finished
	animation_finished = true


func Enter(): 
	if already_entered:
		return
	already_entered = true
	SFX.stream = load("res://assets/audio/SFX/BigHit2.mp3")
	SFX.play()
	Player.position.x += 20 #move backward 
	grab_attempt_animation()


func Update(delta: float):
	if not animation_finished:
		return
	
	var move_to_state = {
			"KUZUSHI": "PlayerKuzushi",
			"KUZSHI_SPECIAL": "PlayerSuperKuzushi",
			"THROW": "PlayerThrow",
			"THROW_SPECIAL": "PlayerSuperThrow",
			"GRAB": "PlayerGrab",
	}
	# If animation is done, check transitions
	if animation_finished:
		# Check for any matching move in current_move_sequence
		for move in move_to_state.keys():
			if InputParser.current_move_sequence.has(move) or str(InputParser.exported_move) == move:
				Transition(move_to_state[move])
				InputParser.current_move_sequence = []
				InputParser.exported_move = []
				return
			else: 
				InputParser.current_move_sequence = []
				InputParser.exported_move = []
				Transition("PlayerIdle")

		# If no move matches, go back to idle
		InputParser.current_move_sequence.clear()
		InputParser.direction_history.clear()
		Transition("PlayerIdle")

#func _on_hitbox_body_entered(body):
	#if body.is_in_group("Enemy"):
		#deal_damage(body)
		#AudioManager.play_sound(AudioManager.PLAYER_ATTACK_HIT, 0, 1)

func Transition(newstate : String):
		state_transition.emit(self, newstate)


func _on_hitbox_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.

func Exit():
	already_entered = false
