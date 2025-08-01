extends State
class_name PlayerSuperGrab
@export var Player: CharacterBody2D
@export var AnimPlayer: AnimationPlayer
@onready var Best_Move = AI.BestMove("EnemyGrab")
@export var Hurtbox_1: CollisionShape2D
@export var Hitbox_1: CollisionShape2D
@export var SFX: AudioStreamPlayer 
var animation_finished = false
#@onready var Grabs = $"../../Hitbox/Grabs"

func Enter(): 
	SFX.stream = load("res://assets/audio/SFX/Suprise1.mp3")
	SFX.play()
	Player.position.x += 30 #move backward 
	#print("Grip attempt started.")
	await grab_attempt_animation()
	#Grabs.disabled = false

func Update(delta: float):
	var move_to_state = {
			"KUZUSHI": "PlayerKuzushi",
			"KUZSHI_SPECIAL": "PlayerSuperKuzushi",
			#"GRAB": "PlayerGrab",
			"THROW_SPECIAL": "PlayerSuperThrow"
	}
	
	if animation_finished:
		# Check for any matching move in current_move_sequence
		for move in move_to_state.keys():
			if InputParser.current_move_sequence.has(move) or str(InputParser.exported_move) == move:
				Transition(move_to_state[move])
				return
			else: 
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


func grab_attempt_animation():
	AnimPlayer.play("Super_Grab")
	animation_finished = false
	await AnimPlayer.animation_finished
	animation_finished = true
